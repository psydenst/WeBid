
import { getHighestBid } from "@/services/web3-service";


export const getData = async () => {
    const res = await getHighestBid();
    const body = await res;

    console.log(body)
    return body;
}
