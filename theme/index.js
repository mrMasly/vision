import palette from './palette.js';
import rgba from './rgba.js';
import vTheme from './vTheme.vue';
import Vue from 'vue'

const VALID_THEME_TYPE = ['primary', 'accent', 'background', 'warn', 'hue-1', 'hue-2', 'hue-3'];
const DEFAULT_THEME_COLORS = {
  primary: 'blue',
  accent: 'red',
  warn: 'red',
  background: 'white'
};

const createNewStyleElement = (style, name) => {
  let styleId = 'v-theme-' + name;
  style = style.replace(/THEME_NAME/g, styleId);

  if (Meteor.isClient) {
    let head = document.head;
    let styleElement = head.querySelector('#' + styleId);

    if (!styleElement) {
      let newTag = document.createElement('style');

      newTag.type = 'text/css';
      newTag.id = styleId;
      newTag.textContent = style;

      head.appendChild(newTag);
    } else {
      styleElement.textContent = style;
    }
  } else {
    if(Meteor.__styles == null) {
      Meteor.__styles = [];
    }
    Meteor.__styles.push('<style type="text/css" id="'+styleId+'">'+style+'</style>');
  }


};

let registeredThemes = [];
let registeredPrimaryColor = {};

const parseStyle = (style, theme, name) => {
  VALID_THEME_TYPE.forEach((type) => {
    style = style.replace(RegExp('(' + type.toUpperCase() + ')-(COLOR|CONTRAST)-?(A?\\d*)-?(\\d*\\.?\\d+)?', 'g'), (match, paletteType, colorType, hue, opacity) => {
      let color;
      let colorVariant = +hue === 0 ? 500 : hue;

      if (theme[type]) {
        if (typeof theme[type] === 'string') {
          color = palette[theme[type]];
        } else {
          color = palette[theme[type].color] || palette[DEFAULT_THEME_COLORS[type]];
          colorVariant = +hue === 0 ? theme[type].hue : hue;
        }
      } else {
        color = palette[DEFAULT_THEME_COLORS[type]];
      }

      if (colorType === 'COLOR') {
        let isDefault = palette[theme[type]];

        if (!hue && !isDefault) {
          if (type === 'accent') {
            colorVariant = 'A200';
          } else if (type === 'background') {
            colorVariant = 50;
          }
        }

        if (type === 'primary') {
          registeredPrimaryColor[name] = color[colorVariant];
        }

        if (opacity) {
          return rgba(color[colorVariant], opacity);
        }

        return color[colorVariant];
      }

      if (color.darkText.indexOf(colorVariant) >= 0) {
        if (opacity) {
          return rgba('#000', opacity);
        }

        return 'rgba(0, 0, 0, .87)';
      }

      if (opacity) {
        return rgba('#fff', opacity);
      }

      return 'rgba(255, 255, 255, .87)';
    });
  });

  return style;
};

const registerTheme = (theme, name, themeStyles) => {
  let parsedStyle = [];

  themeStyles.forEach((style) => {
    parsedStyle.push(parseStyle(style, theme, name));
  });

  createNewStyleElement(parsedStyle.join('\n'), name);
};

const registerAllThemes = (themes, themeStyles) => {
  let themeNames = themes ? Object.keys(themes) : [];

  themeNames.forEach((name) => {
    registerTheme(themes[name], name, themeStyles);
    registeredThemes.push(name);
  });
};

const changeHtmlMetaColor = (color) => {
  if(Meteor.isClient) {
    let themeColorElement = document.querySelector('meta[name="theme-color"]');

    if (themeColorElement) {
      themeColorElement.setAttribute('content', color);
    } else {
      themeColorElement = document.createElement('meta');
      themeColorElement.setAttribute('name', 'theme-color');
      themeColorElement.setAttribute('content', color);

      document.head.appendChild(themeColorElement);
    }
  } else {

  }
};

// export default function install(Vue) {
  Vue.material = new Vue({
    data: () => ({
      styles: [],
      currentTheme: null,
      inkRipple: true
    }),
    methods: {
      addStyle(css) {
        this.styles.push(css.replace(/\/\/\s\d+/g, ''));
      },
      registerTheme(name, spec) {
        let theme = {};

        if (typeof name === 'string') {
          theme[name] = spec;
        } else {
          theme = name;
        }

        registerAllThemes(theme, this.styles);
      },
      applyCurrentTheme(themeName) {
        changeHtmlMetaColor(registeredPrimaryColor[themeName]);
        if(Meteor.isClient) {
          document.body.classList.remove('v-theme-' + this.currentTheme);
          document.body.classList.add('v-theme-' + themeName);
        } else {
          console.log('change', themeName);
        }
        this.currentTheme = themeName;
      },
      setCurrentTheme(themeName) {
        if (registeredThemes.indexOf(themeName) >= 0) {
          this.applyCurrentTheme(themeName);
        } else {
          if (registeredThemes.indexOf('default') === -1) {
            this.registerTheme('default', DEFAULT_THEME_COLORS);
          } else {
            console.warn(`The theme '${themeName}' doesn't exists. You need to register it first in order to use.`);
          }

          this.applyCurrentTheme('default');
        }
      }
    }
  });

  Vue.component('v-theme', vTheme);

  Vue.prototype.$material = Vue.material;
  // Vue.material.registerTheme('default', DEFAULT_THEME_COLORS)
  // Vue.material.setCurrentTheme('default');
// }
