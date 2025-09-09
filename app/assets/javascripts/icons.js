function getSharedMapIcons() {
    return {
         // 出発地マーカー
        start: {
            path: google.maps.SymbolPath.CIRCLE,
            fillColor: '#FF0000', 
            fillOpacity: 1,
            strokeWeight: 1,
            strokeColor: '#333',
            scale: 6,
        },

        // 目的地マーカー
        end: {
            path: google.maps.SymbolPath.CIRCLE,
            fillColor: '#008000', 
            fillOpacity: 1,
            strokeWeight: 1,
            strokeColor: '#333',
            scale: 6,
        }
    }
}