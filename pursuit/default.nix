{ aeson, aeson-better-errors, barrier, base
, base64-bytestring, blaze-builder, blaze-html, blaze-markup
, blaze-svg, bower-json, bytestring, bytestring-trie
, case-insensitive, cheapskate, classy-prelude
, classy-prelude-conduit, classy-prelude-yesod, colour, conduit
, conduit-extra, containers, cookie, crypto-random, data-default
, deepseq, directory, dlist, exceptions, fast-logger, file-embed
, filepath, hjsmin, http-conduit, http-types, hxt, lucid, minlen
, monad-control, monad-logger, mono-traversable, mtl, parallel
, parsec, purescript, safe, shakespeare, split, stdenv
, template-haskell, text, time, transformers, unordered-containers
, vector, wai-extra, wai-logger, wai-middleware-gunzip, warp
, xss-sanitize, yaml, yesod, yesod-core, yesod-form, yesod-static
, mkDerivation, fetchFromGitHub
}:
mkDerivation {
  pname = "pursuit";
  version = "0.4.7";
  src = fetchFromGitHub {
    repo = "pursuit";
    owner = "purescript";
    rev = "d35fe83ce7f318b7c5975acfc7e3f5120d51da15";
    sha256 = "1grw26q12dy644lx7hqs8dhpgf295mb1lwkhx25gy4n3sr490b8z";
  };
  patches = [ ./pursuit.patch ];
  isLibrary = false;
  isExecutable = true;
  doHaddock = false;
  libraryHaskellDepends = [
    aeson aeson-better-errors barrier base base64-bytestring
    blaze-builder blaze-html blaze-markup blaze-svg bower-json
    bytestring bytestring-trie case-insensitive cheapskate
    classy-prelude classy-prelude-conduit classy-prelude-yesod colour
    conduit conduit-extra containers cookie crypto-random data-default
    deepseq directory dlist exceptions fast-logger file-embed filepath
    hjsmin http-conduit http-types hxt lucid minlen monad-control
    monad-logger mono-traversable mtl parallel parsec purescript safe
    shakespeare split template-haskell text time transformers
    unordered-containers vector wai-extra wai-logger
    wai-middleware-gunzip warp xss-sanitize yaml yesod yesod-core
    yesod-form yesod-static
  ];
  executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.mit;
}
