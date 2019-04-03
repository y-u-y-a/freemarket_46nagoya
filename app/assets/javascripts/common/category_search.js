$(function() {

  $('#checkboxes_itemstatus input[id=q_state_in_0]').on("click",function(){
    $('#checkboxes_itemstatus .checkboxes__default input').prop("checked", $(this).prop("checked"));
  });
  $('#checkboxes_shippingmethod input[id=q_shipping_way_in_0]').on("click",function(){
    $('#checkboxes_shippingmethod .checkboxes__default input').prop("checked", $(this).prop("checked"));
  });
  $('#checkboxes_businessstatus input[id=q_business_stats_in_0]').on("click",function(){
    $('#checkboxes_businessstatus .checkboxes__default input').prop("checked", $(this).prop("checked"));
  }); //チェックボックス「すべて」を押すとすべて選択・解除

});
