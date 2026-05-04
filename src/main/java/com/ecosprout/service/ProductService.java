package com.ecosprout.service;

import com.ecosprout.dao.ProductDAO;
import com.ecosprout.model.ProductModel;
import java.sql.SQLException;
import java.util.List;

/**
 * ProductService - Business logic layer for product operations.
 */
public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();

    /** Validates and adds a product. Returns null on success, or an error message. */
    public String addProduct(ProductModel p) throws SQLException {
        if (p.getName() == null || p.getName().trim().isEmpty())
            return "Product name is required.";
        if (p.getPrice() <= 0)
            return "Price must be a positive value.";
        if (p.getQuantity() < 0)
            return "Quantity cannot be negative.";
        productDAO.addProduct(p);
        return null;
    }

    public List<ProductModel> getAllProducts() throws SQLException { return productDAO.getAllProducts(); }
    public List<ProductModel> searchProducts(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) return productDAO.getAllProducts();
        return productDAO.searchProducts(keyword.trim());
    }
    public List<ProductModel> getProductsByVendor(int vendorId) throws SQLException { return productDAO.getProductsByVendor(vendorId); }
    public ProductModel getProductById(int id) throws SQLException { return productDAO.getProductById(id); }
    public boolean updateProduct(ProductModel p) throws SQLException { return productDAO.updateProduct(p); }
    public boolean deleteProduct(int id) throws SQLException { return productDAO.deleteProduct(id); }
    public int countProducts() throws SQLException { return productDAO.countProducts(); }
}
