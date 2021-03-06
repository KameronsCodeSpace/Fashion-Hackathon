import React from 'react'
import { Link } from 'react-router-dom'
import Logo from "../../images/A9Logo.png"

const Navbar = ({ logoutUser, isUserLoggedIn, user_id }) => (
    <nav>
        <Link className='logo-nav' to={isUserLoggedIn ? '/' : '/'}>
            <img src={Logo} alt='Logo'></img>
        </Link>
            <h3>Fashion Design</h3>
        <ul className='nav-links'>
            {/* <Link style={navStyle} to="/"><strong><li>Home</li></strong></Link> */}
            {/* <Link style={navStyle} to="/public/designers"><strong><li>Designers</li></strong></Link> */}

            {isUserLoggedIn
                ? (<>
                    <Link style={navStyle} to="/products"><strong><li>Products</li></strong></Link>
                    <Link style={navStyle} to="/map"><strong><li>Manufacturers</li></strong></Link>
                    {/* <Link style={navStyle} to="/portal"><strong><li>Portal</li></strong></Link>
                    <Link style={navStyle} to="/orders"><strong><li>Orders</li></strong></Link> */}
                    <Link to="/" onClick={logoutUser}><strong><li>Log-out</li></strong></Link>
                </>) : (<>
                    <Link style={navStyle} to="/login"><strong><li>Log-In</li></strong></Link>
                    <Link style={navStyle} to="/signup"><strong><li>Sign-Up</li></strong></Link>
                </>)
            }
        </ul>
    </nav>
)

const navStyle = {
    // color: 'black'
}

export default Navbar;

