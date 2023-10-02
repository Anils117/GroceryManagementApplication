package com.anil.gma.controller;


import com.anil.gma.model.Product;
import com.anil.gma.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("product")
public class ProductController {
    @Autowired

    ProductService productService;
    @GetMapping("/")
    public ResponseEntity<String> Home(){
        return new ResponseEntity<>("Welcome to Grocery Management Application..!!", HttpStatus.OK);
    }

    @GetMapping("/getAllProducts")
    public ResponseEntity<List<Product>> getAllProducts(){
        return productService.getAllProducts();
    }

    @GetMapping("/getProduct/{id}")
    public ResponseEntity<Product> getProduct(@PathVariable Integer id){
        return productService.getProduct(id);
    }

    @PostMapping("/addProduct")
    public ResponseEntity<String> addProduct(@RequestBody Product product){
        return productService.addProduct(product);
    }

    @DeleteMapping("/deleteProduct/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable Integer id){
        return productService.deleteProduct(id);
    }
    @PutMapping("/updateProduct")
    public ResponseEntity<String> updateProduct(@RequestBody Product product){
        return productService.updateProduct(product);
    }

}
