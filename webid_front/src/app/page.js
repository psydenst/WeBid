"use client"
import Head from 'next/head';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import style from '../../public/Main.module.css';
import {createAuction} from '@/services/web3-service';

export default function Home() {

  const { push } = useRouter();
  const [message, setMessage] = useState("");

  return (
    <div className={style.body}>
      <Head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel='shorcut icon' href='/favicon.ico' sizes='any'/>
      </Head>
      <Navbar></Navbar>
      <main className={style.main}>

        <div className={style.item}>
          <h1 className={style.sub_title}> <span className={style.title}>Webid</span> a secure plataform for trading tokenized real assets.</h1>
          <p>Seeking an investment opportunity? Explore our open auctions. Whether you need funding for a business project or for healthcare expenses, create your contract with us.</p>
        </div>

        {/* <div className={style.item}>
          <a className={style.btn} href='/actions' >Connect your Wallet</a>
        </div> */}
      </main>
      <Footer></Footer>
    </div>
  )
}
