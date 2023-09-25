"use client";

import Head from 'next/head';

import { getLastTweets } from '@/services/web3-service';

import { useState, useEffect } from 'react';

import Navbar from '@/components/Navbar';

import Card from '@/components/Card';

import Footer from '@/components/Footer';

import styles from '../../../public/Actions.module.css';

import { createAuction } from '@/services/web3-service';

import { putbid } from '@/services/web3-service';


export default function Actions(){
    const [value, setValue] = useState('');
    const handleChange = (event) => {
        const newValue = event.target.value;
        setValue(newValue);
    };

    const handleValue = () => {
        setValue('');
    }

    const bidAction = () =>{
        handleValue();
        const result = putbid();
    } 

    return (
        <div className={styles.body}>

            <Head>
                <title>Webid | Actions</title>
                <meta charSet="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </Head>
            <Navbar />
            <main className={styles.main}>
                <Card/>
                <div className={styles.btns}>
                <input
                    type="number"
                    id="inputBid"
                    value={value}
                    onChange={handleChange}
                    className={styles.responsive_input}
                    />                
                    <button className={styles.bt1} onClick={putbid} >PLACE YOUR BID</button>
                    <button className={styles.bt2} >REQUEST YOUR MONEY</button>

                    <p>Highest Bidder: </p>
                </div>
            </main>
            <Footer/>     
        </div>
    )
}