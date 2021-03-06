import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom'
import{loadManufacturers} from '../store/actions/userActions'
import { ManufacturersPortal, DesignerPortal } from '../Components'

const PortalContainer = ({user,loadManufacturers}) => {
    // This contains all the backend connnections regarding the portal page for either a designer or manufacturers.

    console.log('user', user);
    const [products, setProducts] = useState([]);
    const [manufacturers, setManufacturers] = useState([]);
    const [manufacturerProducts, setManufacturersProducts] = useState([]);

    const fetchAllDesigns = async () => {
        try {
            const { data: { payload } } = await axios.get(`/products/designer/${user.user_id}`)
            setProducts(payload)
            console.log(payload);
        } catch (error) {
            console.log(error);
        }
    }

    const fetchAllManufacturers = async () => {
        try {
            const { data: { payload } } = await axios.get(`/manufacturers/all`)
            setManufacturers(payload)
            loadManufacturers(payload)
            console.log(payload);
        } catch (error) {
            console.log(error);
        }
    }

    const fetchAllManufacturersProducts = async () => {
        try {
            const { data: { payload } } = await axios.get(`/products/manufacturer/${user.manufacture_id}`)
            setManufacturersProducts(payload)
            console.log('manu', payload);
        } catch (error) {
            console.log(error);
        }
    }

    useEffect(() => {
        if (user.account_type === 'DESIGNER') {
            fetchAllDesigns()
            fetchAllManufacturers()
        } else if (user.account_type === 'MANUFACTURER') {
            fetchAllManufacturersProducts()
        }
    }, [user])

    if (user.account_type === 'DESIGNER') {
        return <DesignerPortal
            products={products}
            manufacturers={manufacturers}
        />
    } else if (user.account_type === 'MANUFACTURER') {
        return <ManufacturersPortal
            manufacturerProducts={manufacturerProducts}
        />
    } else {
        return <Redirect to="/login" />
    }
}

const mapStateToProps = ({ authReducer: { user } }) => { return { user } }
const mapDispatchToProps = (dispatch) => {
    return {
        loadManufacturers: data => dispatch(loadManufacturers(data))
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(PortalContainer)