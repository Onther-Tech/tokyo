pragma solidity^0.4.18;

import "./base/crowdsale/BaseCrowdsale.sol";
import "./base/crowdsale/MintableBaseCrowdsale.sol";
import "./base/crowdsale/BonusCrowdsale.sol";
import "./base/crowdsale/PurchaseLimitedCrowdsale.sol";
import "./base/crowdsale/MinimumPaymentCrowdsale.sol";
import "./base/crowdsale/BlockIntervalCrowdsale.sol";
import "./base/crowdsale/KYCCrowdsale.sol";
import "./base/crowdsale/StagedCrowdsale.sol";
import "./base/crowdsale/FinishMintingCrowdsale.sol";

contract AuditFullFeaturesMintableCrowdsale is BaseCrowdsale, MintableBaseCrowdsale, BonusCrowdsale, PurchaseLimitedCrowdsale, MinimumPaymentCrowdsale, BlockIntervalCrowdsale, KYCCrowdsale, StagedCrowdsale, FinishMintingCrowdsale {

  bool public initialized;

  // constructor parameters are left padded bytes32.

  function AuditFullFeaturesMintableCrowdsale(bytes32[6] args) 
    BaseCrowdsale()
    MintableBaseCrowdsale(
      parseAddress(args[0]))
    BonusCrowdsale()
    PurchaseLimitedCrowdsale(
      parseUint(args[1]))
    MinimumPaymentCrowdsale(
      parseUint(args[2]))
    BlockIntervalCrowdsale(
      parseUint(args[3]))
    KYCCrowdsale(
      parseAddress(args[4]))
    StagedCrowdsale(
      parseUint(args[5]))
    FinishMintingCrowdsale() public {}
  

  function parseBool(bytes32 b) internal pure returns (bool) {
    return b == 0x1;
  }

  function parseUint(bytes32 b) internal pure returns (uint) {
    return uint(b);
  }

  function parseAddress(bytes32 b) internal pure returns (address) {
    return address(b & 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff);
  }

  function generateHoldersTokens(uint256 _targetTotalSupply) internal {

      generateTargetTokens(0x557678cf28594495ef4b08a6447726f931f8d787, _targetTotalSupply, 100);
  }

  function init(bytes32[] args) public {
    uint _startTime = uint(args[0]);
    uint _endTime = uint(args[1]);
    uint _rate = uint(args[2]);
    uint _coeff = uint(args[3]);
    uint _cap = uint(args[4]);
    uint _goal = uint(args[5]);
    uint _lockerRatio = uint(args[6]);
    uint _crowdsaleRatio = uint(args[7]);
    address _vault = address(args[8]);
    address _locker = address(args[9]);
    address _nextTokenOwner = address(args[10]);

    require(_startTime >= now);
    require(_endTime >= _startTime);
    require(_rate > 0);
    require(_coeff > 0);
    require(_cap > 0);
    require(_goal > 0);
    require(_lockerRatio > 0);
    require(_crowdsaleRatio > 0);
    require(_vault != address(0));
    require(_locker != address(0));
    require(_nextTokenOwner != address(0));
    
    startTime = _startTime;
    endTime = _endTime;
    rate = _rate;
    coeff = _coeff;
    cap = _cap;
    goal = _goal;
    lockerRatio = _lockerRatio;
    crowdsaleRatio = _crowdsaleRatio;
    vault = MultiHolderVault(_vault);
    locker = Locker(_locker);
    nextTokenOwner = _nextTokenOwner;
  }
}




