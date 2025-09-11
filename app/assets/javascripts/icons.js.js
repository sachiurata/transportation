function getSharedMapIcons() {
    return {
         // 出発地マーカー
        start: {
            url: "<%= asset_path('start_marker.svg') %>",
            scaledSize: new google.maps.Size(24, 24), // アイコンの表示サイズ
            anchor: new google.maps.Point(12, 12) // アイコンのアンカー位置（中心に設定）
        },

        // 目的地マーカー
        end: {
            url: "<%= asset_path('end_marker.svg') %>",
            scaledSize: new google.maps.Size(24, 24), // アイコンの表示サイズ
            anchor: new google.maps.Point(12, 12) // アイコンのアンカー位置（中心に設定）
        }
    }
}