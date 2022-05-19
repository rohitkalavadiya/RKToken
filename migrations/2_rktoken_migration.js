const RKToken = artifacts.require("RKToken");

module.exports = function (deployer) {
  deployer.deploy(RKToken);
};
