{% set leancloud_uri = '//cdn1.lncld.net/static/js/3.11.1/av-min.js' %}
{% if theme.vendors.leancloud %}
  {% set leancloud_uri = theme.vendors.leancloud %}
{% endif %}
<script src="{{ leancloud_uri }}"></script>

{% set valine_uri = '//unpkg.com/valine/dist/Valine.min.js' %}
{% if theme.vendors.valine %}
  {% set valine_uri = theme.vendors.valine %}
{% endif %}
<script src="{{ valine_uri }}"></script>

<script>
  var GUEST = ['nick', 'mail', 'link'];
  var guest = '{{ theme.valine.guest_info }}';
  guest = guest.split(',').filter(function(item) {
    return GUEST.indexOf(item) > -1;
  });
  new Valine({
    el: '#comments',
    verify: {{ theme.valine.verify }},
    notify: {{ theme.valine.notify }},
    appId: '{{ theme.valine.appid }}',
    appKey: '{{ theme.valine.appkey }}',
    placeholder: '{{ theme.valine.placeholder }}',
    avatar: '{{ theme.valine.avatar }}',
    meta: guest,
    pageSize: '{{ theme.valine.pageSize }}' || 10,
    visitor: {{ theme.valine.visitor }},
    lang: '{{ theme.valine.language }}' || 'zh-cn'
  });
  
  $(".vmail").attr("type","text")
  function tips(){
    pattern=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
    console.log($(".vmail").val())
    if(!pattern.test($(".vmail").val())){
      $(".vmail").attr("placeholder","请留下正确格式的邮箱")
      $(".vmail").css("box-shadow", "rgba(255, 120, 120, 0.3) 0px 7px 5px -2px")
      $(".vmail").css("border-bottom", "solid 1px rgba(255, 120, 120,0.75)")

      $("#veditor").addClass("invalid")
      $("#veditor").attr("placeholder","请留下正确格式的邮箱，以便收到回复哟～")
      $("#veditor").attr("disabled","")
      $(".vctrl").css("display","none")
      $(".vsubmit").css("display","none")
    }else{
      $(".vmail").attr("placeholder","邮箱")
      $(".vmail").removeAttr("style")


      $("#veditor").removeClass("invalid")
      $("#veditor").attr("placeholder","来交♂流一下8？支持markdown语法喔？")
		  $("#veditor").removeAttr("disabled")
		  $(".vctrl").css("display","")
		  $(".vsubmit").css("display","")
	  }
  }
  $(":input").filter(".vinput").on("input",tips)
  $(":input").filter(".vinput").on("focus",tips)
</script>
