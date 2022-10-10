//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";

contract myContract is ERC20{
    using SafeMath for uint256;

    constructor(uint256 _amount) ERC20("RadioTex", "RTK"){
       _mint(msg.sender, _amount);
    }

    address[] private stakeholders;
    mapping(address => uint256) private stakes;
    mapping(address => uint256) private rewards;

    function isStakeHolder(address _address) public view returns (bool, uint256) {
        for(uint256 i = 0; i< stakeholders.length; i++){
            if(_address == stakeholders[i]){
                return (true, i);
            }
        }
        return (false, 0);
    }

    function addHolder (address _holder) public {
       (bool check,) = isStakeHolder(_holder);
       if(!check){
           stakeholders.push(_holder);
       }
       
    }

    function removeHolder(address _holder) public{
       (bool check, uint256 s) = isStakeHolder(_holder);
       if(check){
           stakeholders[s] = stakeholders[stakeholders.length - 1];
           stakeholders.pop();
       }
    }

    function stakeOf(address _holder) public view returns(uint256){
        return stakes[_holder];
    }

    function createStake(uint256 _stake) public {
        _burn(msg.sender, _stake);
        if(stakes[msg.sender] == 0){
            addHolder(msg.sender);
            stakes[msg.sender] = stakes[msg.sender].add(_stake);
        }
    }

    function removeStake(uint256 _stake) public {
        stakes[msg.sender] = stakes[msg.sender].sub(_stake);
        if(stakes[msg.sender] == 0){
            removeHolder(msg.sender);
            _mint(msg.sender, _stake);
        }
    }

    function totalStakes() public view returns(uint256){
        uint256 _totalStakes = 0;
        for (uint256 s = 0; s < stakeholders.length; s += 1){
           _totalStakes = _totalStakes.add(stakes[stakeholders[s]]);
        }
        return _totalStakes;
    }

    function rewardOf(address _holder) public view returns(uint256){
        return rewards[_holder];
    }

    function totalRewards() public view returns(uint256){
        uint256 _totalRewards = 0;
        for (uint256 s = 0; s < stakeholders.length; s += 1){
           _totalRewards = _totalRewards.add(rewards[stakeholders[s]]);
        }
        return _totalRewards;
    }

    function calculateReward(address _stakeholder) public view returns(uint256){
        return stakes[_stakeholder] / 100;
    }

    function distributeRewards() public{
        for (uint256 s = 0; s < stakeholders.length; s += 1){
            address stakeholder = stakeholders[s];
            uint256 reward = calculateReward(stakeholder);
            rewards[stakeholder] = rewards[stakeholder].add(reward);
        }
    }
}
