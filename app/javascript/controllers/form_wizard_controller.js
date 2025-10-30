import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "step", "startMap", "endMap", "startLocation", "endLocation",
    "startMapContainer", "endMapContainer", "timeFieldContainer", "destroyField"
  ];
  static values = {
    apiKey: String,
    // --- ここから追加 ---
    initialStartLocation: String,
    initialEndLocation: String,
    // --- ここまで追加 ---
  };

  PREDEFINED_LOCATIONS = {
    "佐沼高等学校": "POINT(141.20428659054835 38.691352057735635)",
    "登米総合産業高等学校": "POINT(141.24962710758442 38.71916693316383)",
    "登米高等学校": "POINT(141.2803957727903 38.657332687083574)",
    "飛鳥未来きずな高等学校": "POINT(141.17909673841416 38.612043106163384)",
    "その他": "" 
  };

  connect() {
    this.currentStep = 0
    this.showCurrentStep()
    this.loadGoogleMapsAPI()
  }

  loadGoogleMapsAPI() {
    // すでにAPIが読み込まれている場合は、重複して読み込まない
    if (window.google && window.google.maps) {
      this.initMaps()
      return
    }

    const script = document.createElement('script')
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&libraries=places&callback=initWizardMaps`
    script.async = true
    window.initWizardMaps = this.initMaps.bind(this)
    document.head.appendChild(script)
  }

  initMaps() {
    // This function is called by the Google Maps API script.
    // We don't need to initialize the maps here anymore, 
    // as they will be initialized on demand when 'その他' is selected.
  }

  initializeMap(mapTarget, locationTarget, locationValue) {
    let initialCoords = { lat: 38.690, lng: 141.187 }; // デフォルト: 登米市役所
    let existingMarker = null;

    // --- ここから修正 ---
    // 既存の座標があれば、それを初期位置とする
    if (locationValue) {
      const match = locationValue.match(/POINT \((.+) (.+)\)/);
      if (match) {
        initialCoords = { lat: parseFloat(match[2]), lng: parseFloat(match[1]) };
      }
    }
    // --- ここまで修正 ---

    const map = new google.maps.Map(mapTarget, {
      center: initialCoords,
      zoom: 15,
    });

    // --- ここから修正 ---
    // 既存の座標があれば、初期マーカーを設置
    if (locationValue) {
      existingMarker = new google.maps.Marker({
        position: initialCoords,
        map: map,
      });
    }
    // --- ここまで修正 ---

    map.addListener("click", (e) => {
      if (existingMarker) {
        existingMarker.setMap(null);
      }
      existingMarker = new google.maps.Marker({
        position: e.latLng,
        map: map,
      });
      locationTarget.value = `POINT(${e.latLng.lng()} ${e.latLng.lat()})`;
    });
  }

  initStartMap() {
    if (this.startMapTarget && !this.startMapInitialized) {
      this.initializeMap(this.startMapTarget, this.startLocationTarget, this.initialStartLocationValue);
      this.startMapInitialized = true;
    }
  }

  initEndMap() {
    if (this.endMapTarget && !this.endMapInitialized) {
      this.initializeMap(this.endMapTarget, this.endLocationTarget, this.initialEndLocationValue);
      this.endMapInitialized = true;
    }
  }

  toggleTimeField(event) {
    const checkbox = event.currentTarget
    // チェックボックスの親のdiv(border p-2...)から、対応する時刻入力欄を探す
    const container = checkbox.closest('.border').querySelector('[data-form-wizard-target="timeFieldContainer"]')
    const destroyField = container.querySelector('[data-form-wizard-target="destroyField"]')

    if (checkbox.checked) {
      // チェックされたら: 表示して、保存対象にする
      container.classList.remove('d-none')
      destroyField.value = "0" // _destroyを0にすると保存される
    } else {
      // チェックが外れたら: 非表示にして、保存対象から外す
      container.classList.add('d-none')
      destroyField.value = "1" // _destroyを1にすると削除(無視)される
    }
  }

  toggleStartMap(event) {
    const selectedLocation = event.target.value;
    if (selectedLocation === 'その他') {
      this.startMapContainerTarget.style.display = 'block';
      if (!this.startMap) {
        this.initStartMap();
      }
    } else {
      this.startMapContainerTarget.style.display = 'none';
      if (this.PREDEFINED_LOCATIONS[selectedLocation]) {
        this.startLocationTarget.value = this.PREDEFINED_LOCATIONS[selectedLocation];
      } else {
        this.startLocationTarget.value = ""; // Clear if no predefined location
      }
    }
  }

  toggleEndMap(event) {
    const selectedLocation = event.target.value;
    if (selectedLocation === 'その他') {
      this.endMapContainerTarget.style.display = 'block';
      if (!this.endMap) {
        this.initEndMap();
      }
    } else {
      this.endMapContainerTarget.style.display = 'none';
      if (this.PREDEFINED_LOCATIONS[selectedLocation]) {
        this.endLocationTarget.value = this.PREDEFINED_LOCATIONS[selectedLocation];
      } else {
        this.endLocationTarget.value = ""; // Clear if no predefined location
      }
    }
  }

  next() {
    if (this.currentStep < this.stepTargets.length - 1) {
      this.currentStep++
      this.showCurrentStep()
    }
  }

  previous() {
    if (this.currentStep > 0) {
      this.currentStep--
      this.showCurrentStep()
    }
  }

  showCurrentStep() {
    this.stepTargets.forEach((element, index) => {
      element.classList.toggle("d-none", index !== this.currentStep)
    })
  }
}