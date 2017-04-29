export default {
  props: {
    vTheme: String
  },
  data: () => ({
    closestThemedParent: false
  }),
  methods: {
    getClosestThemedParent($parent) {
      if (!$parent || !$parent.$el || $parent._uid === 0) {
        return false;
      }

      if ($parent.vTheme || $parent.vName) {
        return $parent;
      }

      return this.getClosestThemedParent($parent.$parent);
    }
  },
  computed: {
    themeClass() {
      
      if (this.vTheme) {
        return 'v-theme-' + this.vTheme;
      }


      if (this.closestThemedParent) {
        theme = this.closestThemedParent.vName;
      } else {
        theme = this.$material.currentTheme;
      }

      return 'v-theme-' + theme;
    }
  },
  created() {
    this.closestThemedParent = this.getClosestThemedParent(this.$parent);

    if (!this.$material.currentTheme) {
      this.$material.setCurrentTheme('default');
    }
  }
};
