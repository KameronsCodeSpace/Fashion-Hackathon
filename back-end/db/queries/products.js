const db = require('../config')

const getAllProducts = async () => await db.any(`
    SELECT *
    FROM product_design
`)

const getAllProductsByDesigner = async (id) => await db.any(`
    SELECT *
    FROM product_design
    WHERE designer_id = $1
`, [id])

const getAllProductsByDesignCompany = async (id) => await db.any(`
    SELECT *
    FROM product_design
    WHERE designer_id = $1
`, [id])

const getAllProductsByManufacturer = async (id) => await db.any(`
    SELECT *
    FROM product_design
    WHERE manufacturer_id = $1
`, [id])

const getDesignsByStatus = async (param,id) => await db.any(`
    SELECT designs.id, designs.design_file,designs.colors,designs.pattern,
    designs.height,designs.width,designs.designer_id,users.username,users.email, 
    designs.complete
    FROM designs
    INNER JOIN users ON designs.designer_id = users.id
    WHERE users.id = $1 AND complete = ${param}
    ORDER BY designs.id DESC
`, [id])

const updateDesignStatus = async (obj,id) => await db.one(`
    UPDATE designs
    SET complete = $1
    WHERE designs.id = $2
    RETURNING  *
`, [obj.complete, id])

const addNewDesign = async (design) => await db.any(`
    INSERT INTO designs(design_file,colors, pattern, height,width,designer_id)
	VALUES($/design_file/,$/colors/, $/pattern/, $/height/,$/width/,$/designer_id/)
	RETURNING *
`, design)



const getDesignsByDesign = async (id) => await db.any(`
    SELECT manufacturer_id, product_id,
        JSON_OBJECT_AGG(
            material, percentage_used
        ) all_materials
    FROM materials
    JOIN materials_used
    ON materials.id = materials_used.material_id
    WHERE product_id = $1
    GROUP BY manufacturer_id, product_id
`, [id])

module.exports = {
    getAllProducts,
    getAllProductsByDesigner,
    getAllProductsByDesignCompany,
    getAllProductsByManufacturer,    
}
