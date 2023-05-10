export default {
    name: 'Nutrition',
    type: 'document',
    title: 'Nutrition',
    fields: [
        {
            name: 'Product_Name',
            type: 'string',
            title: 'Product Name'
        },
        {
            name: 'Product_Description',
            type: 'text',
            title: 'Product Description'
        },
        {
            name: 'Weight',
            type: 'string',
            title: 'Weight'
        },
        {
            name: 'Price',
            type: 'number',
            title: 'Price'
        },
        {
            name: 'Rating',
            type: 'number',
            title: 'Rating'
        },
        {
            name: 'Image_URL',
            title: 'Image URL',
            type: 'array',
            of: [{ type: 'url' }],
            options: {
                layout: 'grid',
            },
        },
        {
            name: 'Stock_Qty',
            type: 'number',
            title: 'Stock Qty'
        },
        {
            name: 'Category',
            type: 'reference',
            to: [{ type: 'Category' }],
            title: 'Category'
        },

    ]
}