const RKToken = artifacts.require("RKToken");
const RKTokenSale = artifacts.require("RKTokenSale");

module.exports = function (deployer) {
  deployer.deploy(RKToken , 1000000).then(function(){
   // Token price is 0.001 eth
    var tokenPrice = 1000000000000000;
   return  deployer.deploy(RKTokenSale, RKToken.address, tokenPrice);
  });
};
 