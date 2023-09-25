"use client";

import Head from 'next/head';

import { getLastTweets } from '@/services/web3-service';

import { useState, useEffect } from 'react';

import Navbar from '@/components/Navbar';

import Card from '@/components/Card';

import Footer from '@/components/Footer';

import styles from '../../../public/Bid.module.css'

export default function Timeline(){
    
    return (
        <div className={styles.body}>

            <Head>
                <title>CrypX | Timeline</title>
                <meta charSet="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </Head>
            <Navbar />
            <main className={styles.main}>
                <div className={styles.btns}>
                      <button className={styles.bt2} >Creat Bid</button>
                </div>
            </main>
            <Footer/>     
        </div>
    )
}