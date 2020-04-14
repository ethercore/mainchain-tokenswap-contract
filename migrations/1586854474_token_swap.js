var TokenSwap = artifacts.require("TokenSwap");

module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(TokenSwap, "0x");
};
