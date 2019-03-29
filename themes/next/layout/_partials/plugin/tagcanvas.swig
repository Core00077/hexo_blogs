<div class="tags" id="myTags">
  <canvas width="750px" height="750px" style="margin-top:-6.5%;width:90%;height:90%;" id="my3DTags">
    <p>Anything in here will be replaced on browsers that support the canvas element</p>
  </canvas>
</div>
<div class="tags" id="tags">
  <ul style="display: none">
    {{ tagcloud({
      min_font: 25,
      max_font: 48,
      amount: 0,
      color: true,
      start_color: "rgba(0,86,216,0.4)",
      end_color: "rgba(0,86,216,0.75)",
    }) }}
  </ul>
</div>
<script type="text/javascript" src="/js/custom/tagcanvas.js"></script>
<script type="text/javascript" >
    function IsPC(){  
        var userAgentInfo = navigator.userAgent;
        var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");  
        var flag = true;  
        for (var v = 0; v < Agents.length; v++) {  
            if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }  
        }  
        return flag;  
    }
    window.onload = function() {
        if (IsPC()){
            try {
                TagCanvas.Start('my3DTags','tags',{
                textColour: null,
                outlineMethod: 'colour',
                outlineColour: '#0056d8',
                minBrightness: 0.2,
                weight: true, 
                reverse: true,
                depth: 0.6,
                maxSpeed: 0.02,
                bgRadius: 1,
                decel: 1,
                freezeDecel: true,
                wheelZoom: false,
                dragControl: false,
                initial: [-0.2,0.3]
                });
            } catch(e) {
                // something went wrong, hide the canvas container
                document.getElementById('myTags').style.display = 'none';
            }
        }else{
            try {
                TagCanvas.Start('my3DTags','tags',{
                textColour: null,
                outlineMethod: 'colour',
                outlineColour: '#0056d8',
                minBrightness: 0.15,
                weight: true, 
                reverse: true,
                depth: 0.6,
                maxSpeed: 0.01,
                decel: 1,
                bgRadius: 1,
                freezeDecel: true,
                wheelZoom: false,
                dragControl: true,
                initial: [-0.2,0.3]
                });
            } catch(e) {
                // something went wrong, hide the canvas container
                document.getElementById('myTags').style.display = 'none';
            }
        }
    };
</script>