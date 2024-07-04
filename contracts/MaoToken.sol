// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * Mao Token
 * This is a basic ERC20 token template
 * Total supply of 2100000000000000 units
 */
contract MaoToken {
    string public name = "MAO Token";
    string public symbol = "MAO";
    uint8 public decimals = 8;
    uint256 public totalSupply = 21000000 * 10 ** decimals;

    /**
     * MUST trigger when tokens are transferred, including zero value transfers.
     * A token contract which creates new tokens SHOULD trigger 
     * a Transfer event with the _from address set to 0x0 when tokens are created.
     * @param _from address from
     * @param _to  address to
     * @param _value token units
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * MUST trigger on any successful call to approve(address _spender, uint256 _value).
     * @param _owner owner address
     * @param _spender spender address
     * @param _value token units
     */
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /**
     * Token constructor
     */
    constructor(){
        _balances[msg.sender] = totalSupply;
    }


    /**
     * Returns the account balance of another account with address _owner.
     * @param _owner address of owner
     */
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balances[_owner];
    }

    /**
     * Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. 
     * The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend
     * @param _to address to transfer units
     * @param _value units to be transfered
     */
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balanceOf(msg.sender) >= _value, "Insufficient balance");

        _balances[msg.sender] -= _value;
        _balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    /**
     * Allows _spender to withdraw from your account multiple times, up to the _value amount. 
     * If this function is called again it overwrites the current allowance with _value.
     * @param _spender address to spend
     * @param _value quantity
     */
    function approve(address _spender, uint256 _value) public returns (bool success){
        _allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }


    /**
     * Returns the amount which _spender is still allowed to withdraw from _owner.
     * @param _owner address owner
     * @param _spender address to spend
     */
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return _allowances[_owner][_spender];
    }

    /**
     * Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
     * @param _from address of current owner
     * @param _to address to whom it will be sent
     * @param _value number of tokens to be sent
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balanceOf(_from) >= _value, "Insufficient balance");
        require(allowance(_from, msg.sender) >= _value, "Insufficient allowance");

        _balances[_from] -= _value;
        _allowances[_from][msg.sender] -= _value;
        _balances[_to] += _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}