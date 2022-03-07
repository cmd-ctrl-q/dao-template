// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// GovernanceToken is the token used to vote.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract GovernanceToken is ERC20Votes {
    // max token supply of 1,000,000
    uint256 public s_maxSupply = 10000000000000000000000;

    constructor()
        ERC20("GovernanceToken", "GT")
        ERC20Permit("GovernanceToken")
    {
        // mint the max supply (could mint partial)
        _mint(msg.sender, s_maxSupply);
    }

    // Someone knows a hot proposal is coming up
    // So they buy a ton of tokens and then after the vote,
    // They dump it.

    // Create snapshot of tokens everyone has at a certain block.
    // Once a proposal goes through, must have to pick a snapshot of the past
    // That we want to use.

    // The functions below are overrides required by solidity
    // The functions below are overrides required by Solidity.

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20Votes) {
        // also call the _afterTokenTransfer from the ERC20Votes
        // This updates the snapshots, in order to know how many tokens are at each block.
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount) internal override(ERC20Votes) {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20Votes)
    {
        super._burn(account, amount);
    }
}
