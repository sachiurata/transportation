import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    routes: Array,
    startMarkerPath: String,
    endMarkerPath: String,
  }
  static targets = ["map"]

  connect() {
    if (typeof google != "undefined") {
      this.initializeMap();
      return;
    }

    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&callback=initMap&libraries=marker,geometry,drawing`;
    script.async = true;
    window.initMap = this.initializeMap.bind(this);
    document.head.appendChild(script);
  }

  initializeMap() {
    let initialCenter;

    if (this.routesValue && this.routesValue.length > 0) {
      const bounds = new google.maps.LatLngBounds();
      this.routesValue.forEach(route => {
        bounds.extend(new google.maps.LatLng(route.start_point.lat, route.start_point.lng));
        bounds.extend(new google.maps.LatLng(route.end_point.lat, route.end_point.lng));
      });
      initialCenter = bounds.getCenter();
    } else {
      initialCenter = { lat: 38.690, lng: 141.187 };
    }

    this.map = new google.maps.Map(this.mapTarget, {
      center: initialCenter,
      zoom: 12,
    });

    this.directionsService = new google.maps.DirectionsService();

    if (this.routesValue && this.routesValue.length > 0) {
      this.drawRoutesAndMarkers();
    }
  }

  drawRoutesAndMarkers() {
    const startIcon = {
      url: this.startMarkerPathValue,
      scaledSize: new google.maps.Size(32, 32),
    };
    const endIcon = {
      url: this.endMarkerPathValue,
      scaledSize: new google.maps.Size(32, 32),
    };

    this.routesValue.forEach(route => {
      const startMarker = new google.maps.Marker({
        position: route.start_point,
        map: this.map,
        title: route.start_name,
        icon: startIcon,
      });

      const endMarker = new google.maps.Marker({
        position: route.end_point,
        map: this.map,
        title: route.end_name,
        icon: endIcon,
      });

      // --- ここから修正 ---
      // クリックイベントリスナーを削除し、InfoWindowを直接作成して開く

      // 出発地の情報ウィンドウを作成して開く
      const startInfoWindow = new google.maps.InfoWindow({
        content: `<strong>出発地:</strong> ${route.start_name}`
      });
      startInfoWindow.open(this.map, startMarker);

      // 目的地の情報ウィンドウを作成して開く
      const endInfoWindow = new google.maps.InfoWindow({
        content: `<strong>目的地:</strong> ${route.end_name}`
      });
      endInfoWindow.open(this.map, endMarker);
      // --- ここまで修正 ---

      this.directionsService.route({
        origin: route.start_point,
        destination: route.end_point,
        travelMode: 'DRIVING'
      }, (response, status) => {
        if (status === 'OK') {
          new google.maps.DirectionsRenderer({
            map: this.map,
            directions: response,
            suppressMarkers: true,
            polylineOptions: {
              strokeColor: '#007bff',
              strokeOpacity: 0.8,
              strokeWeight: 6
            }
          });
        } else {
          console.error('Directions request failed due to ' + status);
        }
      });
    });
  }
}