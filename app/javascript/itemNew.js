function salesTax (){
  const price = document.getElementById("item-price");
  const addTaxPrice =document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  price.addEventListener("input", () => {
    addTaxPrice.value = Math.floor(price.value * 0.1);
    addTaxPrice.innerHTML = `${addTaxPrice.value}`;
    profit.value = Math.floor(price.value - addTaxPrice.value);
    profit.innerHTML = `${profit.value}`;
  });
  
};

window.addEventListener('load', salesTax);