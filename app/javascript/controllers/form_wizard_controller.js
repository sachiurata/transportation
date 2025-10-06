import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "step",
        "startMap",
        "endMap",
        "startLocation",
        "endLocation",
        "timeFieldContainer", 
        "destroyField",
        "startMapContainer",
        "endMapContainer"
    ]

    static values = {
        apiKey: String
    }

    PREDEFINED_LOCATIONS = {
        "佐沼高等学校": "POINT(141.20428659054835 38.691352057735635)",
        "登米総合産業高等学校": "POINT(141.24962710758442 38.71916693316383)",
        "登米高等学校": "POINT(141.2803957727903 38.657332687083574)",
        "飛鳥未来きずな高等学校": "POINT(141.17909673841416 38.612043106163384)",
        "自宅": "" 
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
        this.initStartMap()
        this.initEndMap()
    }

    initStartMap() {
        const intialPosition = { lat: 38.692019265813514, lng: 141.1876826454518 };

        const map = new google.maps.Map(this.startMapTarget, {
            zoom: 12,
            center: intialPosition,
            mapId: "ce37841bfd2baaafb40ee105",
        });

        const marker = new google.maps.Marker({
            position: intialPosition,
            map: map,
            draggable: true
        });

        marker.addListener('dragend', (event) => {
            const lat = event.latLng.lat();
            const lng = event.latLng.lng();
            this.startLocationTarget.value = `POINT(${lng} ${lat})`;
            console.log("Start Location:", this.startLocationTarget.value);
        });
    }

    initEndMap() {
        const initialPosition = { lat: 38.692019265813514, lng: 141.1876826454518 };

        const map = new google.maps.Map(this.endMapTarget, {
            zoom: 12,
            center: initialPosition,
            mapId: "ce37841bfd2baaafb40ee105",
        });

        const marker = new google.maps.Marker({
            position: initialPosition,
            map: map,
            draggable: true
        });

        marker.addListener('dragend', (event) => {
            const lat = event.latLng.lat();
            const lng = event.latLng.lng();
            this.endLocationTarget.value = `POINT(${lng} ${lat})`;
            console.log("End Location:", this.endLocationTarget.value);
        });
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
        if (selectedLocation === '自宅') {
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
        if (selectedLocation === '自宅') {
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

    initMaps() {
        // This function is called by the Google Maps API script.
        // We don't need to initialize the maps here anymore, 
        // as they will be initialized on demand when '自宅' is selected.
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