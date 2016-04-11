# Base 32 (crockford variant) encoding/decoding for JavaScript

This is an implementation of base32 (crockford variant) encoding and decoding for node.js/browser, focused on the browser with 0 dependencies

It's based on [base32-browser](https://github.com/VictorBjelkholm/base32-js) which is based on [base32-js](https://github.com/agnoster/base32-js).

## What about the n other base32 npm packages?

The purpose of this fork is: **it's streamlined for the browser** and **it actually conforms to [crockfords variant](https://en.wikipedia.org/wiki/Base32#Crockford.27s_Base32)**.

## Getting started

In your shell, install with npm:

```sh
npm install base32-crockford-browser
```

In your code:

```javascript
var base32 = require('base32-crockford-browser')

// simple api

var encoded = base32.encode('some data to encode')
var decoded = base32.decode(encoded)
```

## Minispec

- The *encoding* alphabet consists of the numerals 0-9 and the letters a-z, excluding a few letters that might look like numbers, which we simply interpret as follows:

  - I -> 1
  - L -> 1
  - O -> 0

- When *decoding*, capital letters are converted to lowercase and the "ambiguous" letters mentioned above converted to their numeric counterparts.
- Each character corresponds to 5 bits of input.
- Lexicographic order of strings is preserved through Base 32 encoding.

## License

Under MIT License.
