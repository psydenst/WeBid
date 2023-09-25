import React, { useState, useEffect } from "react";
import styles from "../../public/Navbar.module.css";
import { useWindowSize } from "@uidotdev/usehooks";
import Image from "next/image";

export default function Navbar() {
  const [menuOpen, setMenuOpen] = useState(false);
  const size = useWindowSize();

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  const closeMenu = () => {
    setMenuOpen(false);
  };

  return (
    <nav className={styles.navbar}>
      <div className={styles.logo}>
        <Image src="/logo.png" width={90} height={90}/>
      </div>

      {/* Renderize a lista de links em telas maiores que 1002px */}
      {size.width > 1002 && (
        <ul className={`${styles.link_items}`}>
          <li>
            <a href="/">Home</a>
          </li>
          <li>
            <a href="/actions">Auctions</a>
          </li>
          <li>
            <a href="/creat_bid">Tokenization</a>
          </li>
          <li>
            <a href="#">Contact</a>
          </li>
          <li>
            <a href="#">About Us</a>
          </li>
        </ul>
      )}

      {/* Renderize a lista de links quando o menu estiver aberto em telas menores */}
      {menuOpen && size.width <= 1002 && (
        <div className={styles.mobileMenu}>
          <div className={styles.closeButton} onClick={closeMenu}>
            {/* Close button (X) */}
            <span>&times;</span>
          </div>
          <ul className={`${styles.link_items}`}>
            <li>
              <a href="/">Home</a>
            </li>
            <li>
              <a href="/actions">Auctions</a>
            </li>
            <li>
              <a href="#">Create New Auction</a>
            </li>
            <li>
              <a href="#">Contact</a>
            </li>
            <li>
              <a href="#">About Us</a>
            </li>
          </ul>
        </div>
      )}

      {/* Renderize o ícone de menu apenas em telas menores que 1002px */}
      {!menuOpen && size.width <= 1002 && (
        <div className={styles.menuIcon} onClick={toggleMenu}>
          <div className={styles.iconBar}></div>
          <div className={styles.iconBar}></div>
          <div className={styles.iconBar}></div>
        </div>
      )}
    </nav>
  );
}