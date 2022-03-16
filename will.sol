pragma solidity >= 0.7.0 < 0.9.0;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender; //msg sender represents address being called
        fortune = msg.value; //msg value tells us how much ether is being sent
        deceased = false;
    }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // _ means shift back to actual function after modifier funtion runs
    }

    // create modifier so that we only allocate funds if deceased
    modifier mustBeDecased {
        require(deceased == true);
        _;
    }

    // list of family wallets
    address payable [] familyWallets;

    // map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        // add wallets to the family wallets
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        for(uint i = 0; i < familyWallets.length; i++) {
            // transfer funds from contract address to reciever address
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}