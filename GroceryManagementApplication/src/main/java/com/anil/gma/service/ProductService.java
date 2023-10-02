package com.anil.gma.service;


import com.anil.gma.dao.ProductDao;
import com.anil.gma.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    ProductDao productDao;

    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productDao.findAll();
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    public ResponseEntity<Product> getProductById(Integer id) {
        Optional<Product> optproduct = productDao.findById(id);
        if (optproduct.isPresent()){
            Product product = optproduct.get();
            return new ResponseEntity<>(product,HttpStatus.OK);
        }
        return new ResponseEntity<>(new Product(),HttpStatus.NOT_FOUND);
    }

    public ResponseEntity<String> addProduct(Product product) {
        try {
            productDao.save(product);
            return new ResponseEntity<>("Product Added Successfully..!!",HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>("Product Add Failed..!!",HttpStatus.BAD_REQUEST);
        }

    }

    public ResponseEntity<String> deleteProduct(Integer id) {
        try {
            productDao.deleteById(id);
            return new ResponseEntity<>("Product Deleted Successfully ..!",HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>("Product Delete Failed ..!",HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<String> updateProduct(Product product) {
        try {
            productDao.save(product);
            return new ResponseEntity<>("Product Updated Successfully..!!",HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>("Product Update Failed..!!",HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<Product> getProduct(Integer id) {
        Optional<Product> optproduct = productDao.findById(id);
        if(optproduct.isPresent()){
            return new ResponseEntity<>(optproduct.get(),HttpStatus.OK);
        }else{
            return new ResponseEntity<>(new Product(),HttpStatus.BAD_REQUEST);
        }
    }
}
