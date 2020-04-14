pragma solidity 0.4.26;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract TokenSwap {

  address public owner;
  address public tokenAddress;

  constructor(address _owner) public {
    owner = _owner;
  }

  function swapToERE20() public payable {
    require(msg.value > 0);
    IERC20(tokenAddress).transfer(msg.sender, msg.value);
  }

  function swapToNative(uint256 amount) public {
    IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
    msg.sender.transfer(amount);
  }

  function withdrawERE20() public {
    require(msg.sender == owner);

    uint256 amount = IERC20(tokenAddress).balanceOf(address(this));
    IERC20(tokenAddress).transfer(msg.sender, amount);
  }

  function withdrawNative() public {
    require(msg.sender == owner);

    uint256 amount = address(this).balance;
    msg.sender.transfer(amount);
  }

  function changeOwner(address _owner) public {
    require(msg.sender == owner);

    owner = _owner;
  }

  function setTokenAddress(address _tokenAddress) public {
    require(msg.sender == owner);

    tokenAddress = _tokenAddress;
  }

}
