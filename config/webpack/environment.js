const { environment } = require('@rails/webpacker')
const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))

const customConfig = {
    module: {
        rules: [{
                test: /\.(less|css)$/,
                use: [{
                        loader: 'style-loader', // creates style nodes from JS strings,
                    },
                    {
                        loader: 'css-loader', // translates CSS into CommonJS
                    },
                    {
                        loader: 'less-loader', // compiles Less to CSS
                        options: {
                            javascriptEnabled: true,
                            modifyVars: {
                                "@primary-color": "#3f4eae",
                                "@text-color": "rgba(0, 0, 0, .65)",
                                "@text-color-secondary": "rgba(0, 0, 0, .65)",
                                "@border-color-base": "#ebebeb",
                                "@background-color-light": "hsv(0, 0, 98%)"
                            }
                        }
                    },
                ],
            },
            {
                test: /\.s[ac]ss$/i,
                use: [
                    // Creates `style` nodes from JS strings
                    'style-loader',
                    // Translates CSS into CommonJS
                    'css-loader',
                    // Compiles Sass to CSS
                    'sass-loader',
                ],
            },
        ],
    },
}

environment.config.merge(customConfig);
module.exports = environment