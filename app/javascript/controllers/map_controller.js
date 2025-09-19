import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "map" ]
  static values = {
    apiKey: String,
    routes: Array,
    startMarkerPath: String,
    endMarkerPath: String
  }

  connect() {
    // ルート描画オブジェクトを保存する配列を初期化する
    this.routeElements = []
    // APIを読み込む関数を呼び出す
    this.loadGoogleMapsAPI()
  }

  loadGoogleMapsAPI() {
    // すでにAPIが読み込まれている場合は、重複して読み込まないようにする
    if (window.google && window.google.maps) {
      this.initMap()
      return
    }

    // scriptタグを動的に作成
    const script = document.createElement("script")
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&libraries=routes&callback=initMap`
    script.async = true
    script.defer = true
    // Googleのスクリプトが読み込み完了後に呼び出すグローバル関数を定義
    // .bind(this) を使って、initMap内での 'this' がコントローラー自身を指すようにする
    window.initMap = this.initMap.bind(this)
    // scriptタグをheadに追加
    document.head.appendChild(script)
  }

  initMap() {
    // 地図の表示範囲を自動調整するためのオブジェクト
    const bounds = new google.maps.LatLngBounds()
    // 他のメソッドからmapオブジェクトを参照できるように、this.mapに格納する
    this.map = new google.maps.Map(this.mapTarget, {
      mapId: "ce37841bfd2baaafb40ee105",
      disableDefaultUI: true,
    })

    const directionsService = new google.maps.DirectionsService()

    // アイコンの設定
    const startIcon = {
      url: this.startMarkerPathValue,
      scaledSize: new google.maps.Size(24, 24),
    }
    const endIcon = {
      url: this.endMarkerPathValue,
      scaledSize: new google.maps.Size(24, 24),
    }

    // this.routesValue (Railsから渡されたデータ) をループ処理
    this.routesValue.forEach(routeData => {
      const startPoint = new google.maps.LatLng(routeData.start_lat, routeData.start_lng)
      const endPoint = new google.maps.LatLng(routeData.end_lat, routeData.end_lng)

      // マーカーを作成
      const startMarker = new google.maps.Marker({ position: startPoint, map: this.map, icon: startIcon })
      const endMarker = new google.maps.Marker({ position: endPoint, map: this.map, icon: endIcon })

      // ルート検索のリクエストを作成
      const request = {
        origin: startPoint,
        destination: endPoint,
        travelMode: google.maps.TravelMode.DRIVING,
      }

      // ルート検索を実行
      directionsService.route(request, (result, status) => {
        if (status == google.maps.DirectionsStatus.OK) {
          const directionsRenderer = new google.maps.DirectionsRenderer({
            map: this.map,
            directions: result,
            suppressMarkers: true,
            polylineOptions: { strokeColor: "#007bff", strokeOpacity: 0.8, strokeWeight: 5 },
          })

          // 描画した要素を出発地名とセットで保存
          this.routeElements.push({
            start_point_name: routeData.start_point_name,
            renderer: directionsRenderer,
            startMarker: startMarker,
            endMarker: endMarker
          })
        } else {
          console.error("Directions request failed due to " + status)
        }
      })

      // 表示範囲に各座標を追加
      bounds.extend(startPoint)
      bounds.extend(endPoint)
    })

    // すべてのルートが描画されるように地図の表示範囲を調整
    this.map.fitBounds(bounds)
  }

  // プルダウン変更時に呼び出されるfilterメソッドを追加
  filter(event) {
    const selectedName = event.target.value
    const bounds = new google.maps.LatLngBounds()

    this.routeElements.forEach(element => {
      // 条件選択に基づいて表示・非表示を決定
      const isVisible = (selectedName === 'all' || element.start_point_name === selectedName)

      // 表示・非表示を切り替えます
      element.renderer.setMap(isVisible ? this.map : null)
      element.startMarker.setMap(isVisible ? this.map : null)
      element.endMarker.setMap(isVisible ? this.map : null)

      // 表示対象のマーカーだけを地図の表示範囲に含める
      if (isVisible) {
        bounds.extend(element.startMarker.getPosition())
        bounds.extend(element.endMarker.getPosition())
      }
    })

    // 表示するルートが1つ以上ある場合のみ、地図の範囲を調整する
    if (!bounds.isEmpty()) {
      this.map.fitBounds(bounds)
    }
  }
}