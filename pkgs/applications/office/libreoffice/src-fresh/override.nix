{ lib, kdeIntegration, fetchpatch, ... }:
attrs:
{
  postConfigure = attrs.postConfigure + ''
    sed -e '/CPPUNIT_TEST(Import_Export_Import);/d' -i './sw/qa/inc/swmodeltestbase.hxx'
  '';
  configureFlags = attrs.configureFlags ++ [
    (lib.enableFeature kdeIntegration "kf5")
    "--without-system-zxing"
  ];
  patches = attrs.patches or [ ] ++ [
    # CppunitTest_sc_subsequent_filters_test2: fix test depending on current year
    # https://gerrit.libreoffice.org/c/core/+/127361
    (fetchpatch {
      url = "https://github.com/LibreOffice/core/commit/4f448763825f4e906d221d9e1059ea344d7a1ad1.patch";
      sha256 = "sha256-3fgxcgGDMp/zbZ+0nAlZC+skZZmBbU7O74G5aPV67M0=";
    })
    # CppunitTest_sc_subsequent_filters_test2: check format instead of string
    # https://gerrit.libreoffice.org/c/core/+/127887
    (fetchpatch {
      url = "https://github.com/LibreOffice/core/commit/d5f36648643399ad63006a97a1f58b81690ccddf.patch";
      sha256 = "sha256-IOvY92jYxF8kH3IrNL5FlUSLAF04XOBglVhsF8I+/EU=";
    })
  ];
}
