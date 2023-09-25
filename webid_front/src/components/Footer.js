import a from "next/link";
import Image from "next/image";
import styles from '../../public/Footer.module.css'


export default function Footer(){
    return (
        <footer className={styles.footer}>
            <p>&copy; 2023 Webid All Rights Reserved.</p>
        </footer>
    )
}