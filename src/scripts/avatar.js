/*
 * jQuery LetterAvatar
 * 
 * based on https://codepen.io/arturheinze/pen/ZGvOMw
 * based on https://gist.github.com/leecrossley/6027780
 */

(function ($) {
    $.fn.generateAvatar = function (initials, color, size) {
        size = size || 64;

        var charIndex, canvas, context, dataURI;
        if (window.devicePixelRatio) {
            size = (size * window.devicePixelRatio);
        }

        charIndex = (initials == "?" ? 72 : initials.charCodeAt(0)) - 64;
        canvas = document.createElement("canvas");
        canvas.width = size;
        canvas.height = size;
        context = canvas.getContext("2d");

        context.fillStyle = color;
        context.fillRect(0, 0, canvas.width, canvas.height);
        context.font = Math.round(canvas.width / 2) + "px Arial";
        context.textAlign = "center";
        context.fillStyle = "#FFFFFF";
        context.fillText(initials, size / 2, size / 1.5);

        dataURI = canvas.toDataURL();
        canvas = null;

        return dataURI;
    };

    $.fn.avatar = function (options) {
        options = $.extend({
            // Default options
            colors: [
                "#F44336", // red
                "#e91e63", // pink
                "#9c27b0", // purple
                "#673ab7", // deep purple
                "#3f51b5", // indigo
                "#2196F3", // blue
                "#03a9f4", // light purple
                "#00bcd4", // cyan
                "#009688", // teal
                "#4CAF50", // green
                "#8bc34a", // light green
                "#cddc39", // lime
                "#ffeb3b", // yellow
                "#ffc107", // amber
                "#ff9800", // orange
                "#ff5722", // deep orange
                "#795548", // brown
                "#607d8b", // blue grey
                "#9e9e9e", // grey
            ],
            size: 64,
            removeSpecialCharacters: true
        }, options);

        return this.each(function () {
            // Get avatar string
            var name = $(this).attr("data-avatar");
            if (!name || !name.length)
                return;

            // Remove special characters
            if (options.removeSpecialCharacters) {
                name = name.replace(/[^a-zA-Z ]/g, "");
            }

            // Get initials
            var initials = [];
            for (var i = 0; i < name.length; i++) {
                var c = name.charAt(i);
                if (String(c) == String(c).toUpperCase() && c != ' ') {
                    initials.push(c);
                }
            }

            initials = initials.slice(0, 2);
            if (initials.length == 0 && name.length >= 2) {
                // Use the first two letters if there are no uppercase ones
                initials = name.charAt(0) + name.charAt(1);
            } else {
                initials = initials.join("");
            }

            // Capitalize initials
            initials = initials.toUpperCase();

            // Get random color
            var color = options.colors[Math.floor(Math.random() * options.colors.length)];

            // Apply avatar
            $(this).attr("src", $(this).generateAvatar(initials, color, options.size));

            // Remove data-avatar attribute
            $(this).removeAttr("data-avatar");
        });
    };
}(jQuery));