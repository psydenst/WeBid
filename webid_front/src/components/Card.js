import React, { useState, useEffect } from 'react';
import a from "next/link";
import Image from "next/image";
import styles from '../../public/Card.module.css'
import {getHighestBid} from '@/services/web3-service'
import { getData } from '@/helpers/request';

export default function Card() {

    const [time, setTime] = useState({ hours: 0, minutes: 4, seconds: 42 });
    const [value, setValue] = useState(0);


    useEffect(() => {
      const countdown = setInterval(() => {
        // Verifica se o tempo chegou a zero
        if (time.hours === 0 && time.minutes === 0 && time.seconds === 0) {
          clearInterval(countdown); // Para o contador quando o tempo atingir zero
        } else {
          // Atualiza o tempo a cada segundo
          if (time.seconds > 0) {
            setTime({ ...time, seconds: time.seconds - 1 });
          } else {
            if (time.minutes > 0) {
              setTime({ ...time, minutes: time.minutes - 1, seconds: 59 });
            } else {
              setTime({ ...time, hours: time.hours - 1, minutes: 59, seconds: 59 });
            }
          }
        }
      }, 1000);
  
      // Limpa o intervalo quando o componente é desmontado
      return () => clearInterval(countdown); 
    }, [time]);


    /*
    useEffect( () => {

      

      // const resp = async () => { 
      //   const r = await getHighestBid();
      //   const r2 = await r.json();
      //   return r2;
      // }
      const value2 = getData();
      setValue( value2 )
      console.log(value2)
      
    }, [value]);
    */
  
    // Formata o tempo como uma string HH:MM:SS
    const formattedTime = `${String(time.hours).padStart(2, '0')}:${String(
      time.minutes
    ).padStart(2, '0')}:${String(time.seconds).padStart(2, '0')}`;
    const highestBid = `${String(value)}`;
    console.log("highestBid" + highestBid);
    return (
      <div className={styles.card}>
        <Image src="/t-shirt.png" width={558} height={423} />
        <div className={styles.card_content}>
          <h2>Webid T-shirt</h2>
          <p>
            The million Zeniq t-shirt.
          </p>
        </div>
        <button>{formattedTime}</button>
        <button>{value}</button>
      </div>
    );
  }