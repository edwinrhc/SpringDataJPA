package SpringAuditJPA.controller;


import SpringAuditJPA.entity.Product;
import SpringAuditJPA.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/jpa")
@RequiredArgsConstructor // aquí nos evitamos escribir auto wride
public class ProductController {

    private final ProductRepository productRepository;

    // Create Product
    @PostMapping("/create")
    public ResponseEntity<String> addProduct(@RequestBody Product product){
        this.productRepository.save(product);
        return new ResponseEntity<>("Producto creado correctamente",HttpStatus.CREATED);
    }

    // Update Product
    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateProduct(@PathVariable int id,
                                                @RequestBody Product product){
        Product productFound = this.productRepository.findById(id).orElseThrow();
        productFound.setName(product.getName());
        productFound.setPrice(product.getPrice());
        this.productRepository.save(productFound);
        return new ResponseEntity<>("Producto actualizado correctamente",HttpStatus.OK);
    }

    // Delete Product
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable int id){
        this.productRepository.deleteById(id);
        return new ResponseEntity<>("Producto eliminado correctamente",HttpStatus.OK);
    }
}
