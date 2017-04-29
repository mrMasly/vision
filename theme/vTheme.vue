<script>
  export default {
    props: {
      vTag: String,
      vName: {
        type: String,
        default: 'default'
      }
    },
    data: () => ({
      name: 'v-theme'
    }),
    render(render) {
      if (this.vTag || this.$slots.default.length > 1) {
        return render(this.vTag || 'div', {
          staticClass: 'v-theme'
        }, this.$slots.default);
      }
      return this.$slots.default[0];
    }
  };
</script>
