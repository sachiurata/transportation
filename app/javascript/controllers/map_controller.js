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
    // connect時には、APIを読み込む関数を呼び出すだけにします
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

    // 地図を初期化
    // this.mapTarget は data-map-target="map" で指定したdiv要素を指します
    const map = new google.maps.Map(this.mapTarget, {
      mapId: "YOUR_MAP_ID", // 必要に応じてご自身のMap IDを設定してください
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
      new google.maps.Marker({ position: startPoint, map: map, icon: startIcon })
      new google.maps.Marker({ position: endPoint, map: map, icon: endIcon })

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
            map: map,
            directions: result,
            suppressMarkers: true, // 自前のマーカーを使うので、デフォルトマーカーは非表示
            polylineOptions: {
              strokeColor: "#007bff", // 線の色
              strokeOpacity: 0.8,   // 線の不透明度
              strokeWeight: 5,      // 線の太さ
            },
          })
        } else {
          console.error("Directions request failed due to " + status)
        }
      })

      // 表示範囲に各座標を追加
      bounds.extend(startPoint)
      bounds.extend(endPoint)
    })

    // 全てのルートが収まるように地図の表示範囲を調整
    map.fitBounds(bounds)
  }
}