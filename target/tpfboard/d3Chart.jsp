<%--
  Created by IntelliJ IDEA.
  User: 陶鹏飞
  Date: 2017/7/13
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>D3</title>
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">

    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="plugins/d3/d3.min.js"></script>
    <script src="plugins/d3/d3pie.min.js"></script>
    <style type="text/css">
        body{
            background-color:#E7EBED;
            font-size: 10px;
            font-family: 'TPF_Font_Thin';
        }

        .container {
            width:100%;
            height: 100%;
            overflow: auto;
            position: absolute;
            padding-top: 10px;
            padding-right: 0px;
            padding-left: 10px;
            padding-bottom: 10px;
            margin-right: auto;
            margin-left: auto;
        }

        /* ================ KPI ================ */
        .vertical-center{
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .KPI-Header{
            color:#666666;
            font-weight:bolder;
            font-family:TPF_Font_Thin;
            font-size:10px;
        }
        .KPI-Body{
            color:#666666;
            font-size:50px;
            font-weight:lighter;
            font-family:TPF_Font_Thin;
        }
        .KPI-Footer{
            /*
             、、、、、、
            */
        }
        .KPI-Footer-Title{
            float:left;
            color:#666666;
        }
        .KPI-Footer-Body{
            float:left;
            color:red;
            font-family:TPF_Font_Thin;
        }
        /* ================ Panel ================ */
        .panel-default {
            border: none;
            border-radius: 0px;
            margin-bottom: 0px;
            box-shadow: none;
            -webkit-box-shadow: none;
        }
        .panel-heading {
            padding: 0px 0px;
            border-bottom: 0px solid transparent;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
        }
        .panel-default > .panel-heading {
            color: #777;
            background-color: #fff;
            border-color: #e6e6e6;
            padding: 10px 10px;
        }
        .panel-default > .panel-body {
            padding: 10px;
            padding-bottom: 10px;
        }
        .panel-default > .panel-body ul {
            overflow: hidden;
            padding: 0;
            margin: 0px;
            margin-top: -5px;
        }
        .panel-default > .panel-body ul li {
            line-height: 27px;
            list-style-type: none;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .panel-default > .panel-body ul li .time {
            color: #a1a1a1;
            float: right;
            padding-right: 5px;
        }
        .panel-footer {
            padding: 10px 15px;
            background-color: #FFFFFF;
            border-top: 0px solid #ddd;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
        }

        .single {
            cursor: pointer;
            border: 1px solid #eee;
            border-radius: 0px;
            text-align: center;
            padding: 10px;
            padding-top: 10px;
            padding-right: 10px;
            margin-bottom: 10px;
        }
        .col-xs-1, .col-sm-1, .col-md-1, .col-lg-1,
        .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2,
        .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3,
        .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4,
        .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5,
        .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6,
        .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7,
        .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8,
        .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9,
        .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10,
        .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11,
        .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
            position: relative;
            min-height: 1px;
            padding-right: 10px;
            padding-left: 0px;
        }
        .row {
            margin-right: 0px;
            margin-left: 0px;
        }
        hr {
            margin-top: 10px;
            margin-bottom: 0px;
            border: 0;
            border-top: 0px solid #eee;
        }

        /*================ 浮动 ================*/
        .floatPanel {
            cursor: pointer;
            border: 1px solid #eee;
            border-radius: 0px;
        }
        .floatPanel:hover, .single.selected:hover {
            -webkit-box-shadow: 0px 0px 35px -8px rgba(0,0,0,0.5);
            -moz-box-shadow: 0px 0px 35px -8px rgba(0,0,0,0.5);
            box-shadow: 0px 0px 35px -8px rgba(0,0,0,0.5);
        }
        .floatPanel.selected {
            background-color: rgba(240, 240, 240, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row clearfix">
            <div class="col-xs-12 last">
                <div class="panel panel-default floatPanel" style="height: 390px;">
                    <div class="panel-heading" style="height: 50px;">
                        <i class="fa fa-pie-chart" style="padding-right: 5px;"></i>饼图实例
                    </div>
                    <div id="pie1" class="panel-body" style="height: 330px;">

                    </div>
                    <div class="panel-footer hidden-xs hidden-sm hidden-md hidden-lg">
                        <div>panel-footer</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        let Pie1 = {};
        /*-------------------------------------------------------------------------*
         *                        Pie1 functions && settings                       *
         *-------------------------------------------------------------------------*/
        Pie1.addCommas = ( nStr ) => {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            let rgx = /(\d+)(\d{3})/;

            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            x2 = x2.slice(0,3);
            return x1 + x2;
        };
        /*-------------------------------------------------------------------------*
         *                             D3 && settings                              *
         *-------------------------------------------------------------------------*/
        (function initD3(){
            let readJSONFile = function(url){
                let jsonData;
                $.ajax({
                    type : 'get',
                    url : url,
                    async : false,
                    dataType : 'json',
                    data : null,
                    success : function(response){
                        jsonData = response;
                    }
                });
                return jsonData;
            };
            /**
             *
             * 数组最小值
             *
             **/
            Array.prototype.min = function() {
                let min = this[0];
                let len = this.length;
                for (let i = 1; i < len; i++){
                    if (this[i] < min){
                        min = this[i];
                    }
                }
                return min;
            }
            /**
             *
             * 数组最大值
             *
             **/
            Array.prototype.max = function() {
                let max = this[0];
                let len = this.length;
                for (let i = 1; i < len; i++){
                    if (this[i] > max) {
                        max = this[i];
                    }
                }
                return max;
            }
            /**
             *
             * 数组求和
             *
             **/
            Array.prototype.sum = function (){
                let result = 0;
                for(let i = 0; i < this.length; i++) {
                    result += this[i];
                }
                return result;
            };
            let urlD3Pie1 = "http://localhost:8090/db";
                //urlD3Pie1 += '&paramstartDay=' + startDay + '&paramendDay=' + endDay + '&parambrandParam=' + brandParam + '&paramplaceParam=' + placeParam + '&paramarea1Param=' + area1Param + '&paramarea2Param=' + area2Param + '&paramarea3Param=' + area3Param + '&paramshopParam=' + shopParam + '&paramoutletParam=' + outletParam;
            let getD3Pie1JSON = readJSONFile(urlD3Pie1).resultset;
            console.log(readJSONFile(urlD3Pie1));
            console.log(getD3Pie1JSON);
            let colors = ['#FF9E16', '#0055B8'];
            let d3Pie = new d3pie("pie1", {
                header: {
                    title: {
                        text: (function(){
                            return getD3Pie1JSON.sort(function(a,b){
                                return b[1]-a[1];
                            })[0][0];
                        })(),
                        color: "#0055B8",
                        fontSize: 24,
                        font: "open sans"
                    },
                    subtitle: {
                        text: (function(){
                            let maxJSON = getD3Pie1JSON.map((value, index, arr) => {
                                let newArr = [];
                                newArr.push(value[1]);
                                return newArr[0];
                            }).max();
                            let sumJSON = getD3Pie1JSON.map((value, index, arr) => {
                                let newArr = [];
                                newArr.push(value[1]);
                                return newArr[0];
                            }).sum();
                            return ((maxJSON / sumJSON) * 100).toFixed(2) + '%';
                        })(),
                        //color: "#0055B8",
                        fontSize: 42,
                        font: "TPF_Font_Thin"
                    },
                    titleSubtitlePadding: 9,
                    location: "pie-center"
                },
                size: {
                    canvasHeight: (function(){
                        return 330;
                    })(),
                    canvasWidth: (function(){
                        return $("#pie1").width();
                    })(),
                    pieInnerRadius: "80%"
                },
                data: {
                    sortOrder: "value-desc",
                    content: getD3Pie1JSON.map((value, index, arr) => {
                        let newArr = [];
                        newArr.push({
                            label: value[0],
                            value: value[1],
                            color: colors[index]
                        });
                        return newArr[0];
                    })
                },
                tooltips: {
                    enabled: true,
                    type: "placeholder",
                    string: "{label}: {value}",
                    placeholderParser: function(index, data) {
                        data.value = Pie1.addCommas(data.value.toFixed(2));
                        return data.value;
                    },
                    styles: {
                        fadeInSpeed: 500,
                        //backgroundColor: "#00cc99",
                        backgroundColor: "silver",
                        backgroundOpacity: 0.8,
                        color: "#ffffcc",
                        borderRadius: 4,
                        font: "verdana",
                        fontSize: 20,
                        padding: 20
                    }
                },
                labels: {
                    outer: {
                        pieDistance: 32
                    },
                    inner: {
                        hideWhenLessThanPercentage: 3
                    },
                    mainLabel: {
                        fontSize: 20
                    },
                    percentage: {
                        color: "#ffffff",
                        decimalPlaces: 0
                    },
                    value: {
                        color: "#adadad",
                        fontSize: 20
                    },
                    lines: {
                        enabled: true
                    },
                    truncation: {
                        enabled: true
                    }
                },
                effects: {
                    pullOutSegmentOnClick: {
                        effect: "linear",
                        speed: 400,
                        size: 8
                    }
                },
                callbacks: {
                    onClickSegment: function(a) {
                        console.log(a.data);
                    }
                }
            });
        })();
    </script>
</body>
</html>
