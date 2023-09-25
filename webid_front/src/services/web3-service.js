import {ethers} from "ethers";
import {auctionHouseABI} from "./ABI.js";
import {zscSigner} from "ethersjs-nomo-plugins/dist/ethersjs_provider";

const auctionHouseAddress = "0xED08F0A5715610bc2301a1CA0b93018167b1C2FA";
let indexAuction;
export async function createAuction()  {
    //await checkIfGasCanBePaid();

    console.info("auction create")
    
    const contract =  new ethers.Contract(auctionHouseAddress, auctionHouseABI, zscSigner);
    const startPrice = ethers.utils.parseEther('0.000042');
    const minIncrease = ethers.utils.parseEther('0.000012');

    const tempoEmMilissegundos =  120015;

    indexAuction = await contract.createNewAuction(120, startPrice, minIncrease); 
    setTimeout(await contract.tradeAuction(indexAuction), tempoEmMilissegundos);
    // temos um leilão na posição 0 do array
    console.log("highest bidder: " + await contract._getHighestBidder(indexAuction));
    console.log("highest bid: " + await contract._getHighestBid(indexAuction));
    console.log("Contract Balance: " + await contract.getContractBalance());
    
}

export async function getHighestBid() {
    //const auctionHouseAddress = "0xAD947f1205a42a6f0e340EEeE73660d0c4671BA3";
    const contract =  new ethers.Contract(auctionHouseAddress, auctionHouseABI, zscSigner);
    const value = await contract._getHighestBid(4);
    return (value / (10**18));
}



export async function putbid()
{

    const contract =  new ethers.Contract(auctionHouseAddress, auctionHouseABI, zscSigner);

    let bidUser = document.getElementById("inputBid").value;
    console.log("bidUser: "  + ethers.utils.parseEther(bidUser));
    const bidUserEther = ethers.utils.parseEther(bidUser);
    const tx = await contract.bid(indexAuction, {value: ethers.utils.parseEther(bidUserEther)});
    //console.log("tx", tx);
    //const receipt = await tx.wait();
    //console.log("receipt", receipt());
} 




async function tradeAuction() {

    const contract =  new ethers.Contract(auctionHouseAddress, auctionHouseABI, zscSigner);


// Crie um temporizador que chamará a função após o período de tempo especificado

} 

async function geBiddersBalance() {
    await contract._getBiddersBalance(4); 
}

async function withdrawBidBefore()
{
    const contract =  new ethers.Contract(auctionHouseAddress, auctionHouseABI, zscSigner);

    contract.withdrawBid(3);

}