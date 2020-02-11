<!DOCTYPE html>
<div class="loginForm">
    <style>
        .yellow{
            background-color: yellow !important;
            transition: all 1s;
            color: #449955;
        }
        .normal{
                  background-color: transparent;
                  transition: all 1s;
              }
    </style>
    <span class="close fa fa-close" id="close" onclick="closeMe();"></span>
    <div class="fullWidWithBGContainer bgcolef">
        {{HEAD_SECTIONS}}
    </div>
    <div class="fullWidWithBGContainer bgcolt8">
        <div class="subNav left rShadow" style="">
            <i class="fa btn fa-arrow-circle-left fa-2x right" onclick="toggleDockWind()" title="Click to Collapse-Expand"></i>
            <div style="">
            <p class="nomargin p-15 white bgcolt8  bold">Filters</p><hr>
            <ul>
                {{FILTERS_UL}}
            </ul>
            </div>
    <div style="" class="bgcolef">
    <p class="nomargin p-15 white bgcolt8  bold">Quick Links</p><hr>
        <ul>
            {{QUICKLINKS_UL}}
        </ul>
    </div>
    </div>
    <div class="right sbnvLdr lShadow" id="linkLoader">{{MODULE_CONTENT}}</div>
    </div>
</div>