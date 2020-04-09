module.exports = {
  plugins: ['stylelint-scss'],
  extends: [
    'stylelint-config-standard',
    'stylelint-config-rational-order',
    './node_modules/prettier-stylelint/config.js'
  ],
  rules: {
    'max-line-length': null, //max文字数を無視
    'function-url-quotes': 'never', //不必要なクォーテーションを禁止( これだけ自動Fixできない )
    'no-descending-specificity': null, //セレクタの詳細度に関する警告を出さない
    'number-leading-zero': 'always', //0.5emなどは.5emに
    'font-weight-notation': null, //font-weightの指定は自由
    'font-family-no-missing-generic-family-keyword': null, //sans-serif / serifを必須にするか。object-fitでエラーださないようにする。
    'at-rule-no-unknown': null, //scssで使える @include などにエラーがでないように
    'scss/at-rule-no-unknown': true //scssでもサポートしていない @ルールにはエラーを出す
  }
};
