package com.c3.g7.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.c3.g7.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer>{

}
