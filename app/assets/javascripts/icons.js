// アイコンのURLを引数で受け取るように変更
function getSharedMapIcons(startIconUrl, endIconUrl) {
    return {
        // 出発地マーカー
        start: {
            url: startIconUrl, // 引数で渡されたURLを使用
            scaledSize: new google.maps.Size(24, 24),
        },

        // 目的地マーカー
        end: {
            url: endIconUrl, // 引数で渡されたURLを使用
            scaledSize: new google.maps.Size(24, 24),
        }
    }
}