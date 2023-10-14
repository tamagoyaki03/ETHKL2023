import Web3 from 'web3';
import VoteJSON from '../contract/Vote.json';

const useWeb3 = () => {
    let web3;
    let voteContract;
    const contractAddress = '0x1a2ee10B320a8D6518126b288aa84111ee756A71';

    // Checking if Web3 is available in the current environment
    if (typeof window !== 'undefined' && window.ethereum) {
        // Use the current provider
        web3 = new Web3(window.ethereum);
        try {
            // Request account access if needed
            window.ethereum.enable();
        } catch (error) {
            // User denied account access...
            console.error('User denied account access');
        }
    } else {
        // Fallback to Infura
        web3 = new Web3(
            new Web3.providers.WebsocketProvider('wss://goerli.infura.io/ws/v3/cb7e63cf28244e4499b4b6fb6162e746')
        );
    }

    try {
        voteContract = new web3.eth.Contract(VoteJSON.abi, contractAddress);
    } catch (error) {
        console.error('Error initializing voteContract:', error);
    }

    return {
        web3,
        voteContract,
        contractAddress
    };
};

export default useWeb3;
