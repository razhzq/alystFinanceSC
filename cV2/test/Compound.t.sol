pragma solidity ^0.8.15;


import "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import {CErc20Delegate} from "../src/CErc20Delegate.sol";
import {CErc20Delegator} from "../src/CErc20Delegator.sol";
import {JumpRateModelV2} from "../src/JumpRateModelV2.sol";
import {Comptroller} from "../src/Comptroller.sol";
import {SimplePriceOracle} from "../src/SimplePriceOracle.sol";
import {InterestRateModel} from "../src/InterestRateModel.sol";
import {MorkNOTE} from "../src/NOTE.sol";



contract CompoundV2Test is Test {

    uint256 mainnetFork;
    uint256 internal constant FORK_BLOCK = 17_052_487;
    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    CErc20Delegate internal delegate;
    CErc20Delegator internal delegator;
    JumpRateModelV2 internal interestRate;
    Comptroller internal comptroller;
    MorkNOTE internal note;
    SimplePriceOracle internal oracle;

    address internal _owner = makeAddr('owner');

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnetFork);
        vm.startPrank(_owner);

        delegate = new CErc20Delegate();
        note = new MorkNOTE();
        interestRate = new JumpRateModelV2(0, //baseRatePerYear
                                           5000000000000000000,
                                           1090000000000000000,
                                           80000000000000000000,
                                           _owner
        );
        //Deploy comptroller
        comptroller = new Comptroller();
        //Deploy cErc20Delegator
        delegator = new CErc20Delegator(
            address(note),
            comptroller,
            interestRate,
            1000000000000000000,
            "alNOTE",
            "alNOTE",
            18,
            payable(address(_owner)),
            address(delegate),
            '0x'
        );
        //deploy oracle 
        oracle = new SimplePriceOracle();

        string memory symbol = delegator.symbol();

        console.log(symbol);
    }

    function testContract() public {

        vm.roll(17052488);
        address returnData = delegate.checkUnderlying();

        

    }

    

}