const { environment } = require('@rails/webpacker')

environment.loaders.append('vue', {
  test: /\.vue$/,
  use: 'vue-loader'
})

module.exports = environment
