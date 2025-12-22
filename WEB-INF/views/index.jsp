<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>YAME SHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="./css/index.css" />
    <script src="js/script.js"></script>
</head>

<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
            <div class="container-fluid px-4 px-lg-5">
                <a class="navbar-brand d-flex align-items-center" href="index.html">
                    <img logo_YaMe_2025.png" alt="Logo" height="35" />
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0 gap-5 text-uppercase fw-bold" style="font-size: 13px">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarSale" role="button"
                                data-bs-toggle="dropdown">
                                <i class="bi bi-battery-full me-1"></i> SALE
                            </a>

                            <ul class="dropdown-menu sale-dropdown" aria-labelledby="navbarSale">
                                <li>
                                    <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">
                                        <span>BLACK FRIDAY</span>
                                        <span class="badge bg-danger ms-2" style="font-size: 10px">HOT</span>
                                    </a>
                                </li>

                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-quan-ao.html">Sale Áo Thun, Áo Khoác, Sơ
                                        Mi</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-quan-dai.html">Sale Quần Dài, Quần Short,
                                        Quần Jeans</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-balo-tui.html">Sale Balo, Túi, Giày</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-vi-non.html">Sale Dép, Ví, Nón, Dây Nịt,
                                        Vớ...</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-manga.html">Manga Super Sale</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Frontend-master/sale/sale-gia-db.html">Sale Phụ Kiện Thể Thao, Đồ
                                        Tiện Ích</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown position-static">
                            <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/Frontend-master/gu/gu.html" id="navbarGu">
                                GU
                            </a>

                            <div class="dropdown-menu mega-menu" aria-labelledby="navbarGu">
                                <div class="row g-0">
                                    <div class="col-md-3 left-menu">
                                        <div class="nav flex-column nav-pills" id="v-pills-tab">
                                            <a class="nav-link active text-start rounded-0" id="v-pills-simple-tab"
                                                href="${pageContext.request.contextPath}/Frontend-master/gu/gu-don-gian.html" data-bs-target="#v-pills-simple">
                                                <i class="bi bi-tshirt me-2"></i> GU ĐƠN GIẢN
                                            </a>

                                            <a class="nav-link text-start rounded-0" id="v-pills-design-tab"
                                                href="${pageContext.request.contextPath}/Frontend-master/gu/gu-thiet-ke.html" data-bs-target="#v-pills-design">
                                                <i class="bi bi-palette me-2"></i> GU THIẾT KẾ
                                            </a>

                                            <a class="nav-link text-start rounded-0" id="v-pills-sport-tab"
                                                href="${pageContext.request.contextPath}/Frontend-master/gu/gu-the-thao.html" data-bs-target="#v-pills-sport">
                                                <i class="bi bi-controller me-2"></i> GU THỂ THAO
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-md-9 right-content">
                                        <div class="tab-content" id="v-pills-tabContent">
                                            <div class="tab-pane fade show active" id="v-pills-simple" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Trạm Thiết Yếu</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/non-brand.html" class="sub-link">Non Branded
                                                            (Bền)</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/seventeen.html" class="sub-link">Seventy Seven</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/theworker.html" class="sub-link">The Worker (nhiều
                                                            túi)</a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Trạm Jean</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/gu.html" class="sub-link">Original Jean</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/tekbackjean.html" class="sub-link">Tek Black
                                                            Jean</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/multicolorjean.html" class="sub-link">Multi color
                                                            Jean</a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Trạm Công Nghệ</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/theminimalist.html" class="sub-link">Minimalist</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/theceo.html" class="sub-link">The CEO</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="v-pills-design" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Trạm dịch chuyển</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/ao/aokhoacdongian.html" class="sub-link">Áo khoác đơn
                                                            giản</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/ao/aokhoaccatinh.html" class="sub-link">Áo khoác cá
                                                            tính</a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Trạm tận hưởng</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/thenostyle.html" class="sub-link">The No Style</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/theweekend.html" class="sub-link">The Weekend</a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <span class="sub-title">Collab Đặc Biệt</span>
                                                        <hr class="my-2" />
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/onepiece.html" class="sub-link">One Piece</a>
                                                        <a href="${pageContext.request.contextPath}/Frontend-master/gu/dragonballz.html" class="sub-link">Dragon Ball Z</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="v-pills-sport" role="tabpanel">
                                                <div class="row g-0 h-100">
                                                    <div class="col-md-4 border-end">
                                                        <div class="list-group list-group-flush pt-2">
                                                            <a href="${pageContext.request.contextPath}/Frontend-master/gu/thebeginer.html" class="sport-link">
                                                                The Beginner (Mới bắt đầu)
                                                            </a>

                                                            <a href="gu/thetrainer.html" class="sport-link">
                                                                The Trainer (Tập chuyên nghiệp)
                                                            </a>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8 bg-white"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item dropdown position-static">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarAo" role="button"
                                data-bs-toggle="dropdown">
                                ÁO
                            </a>

                            <div class="dropdown-menu mega-menu" aria-labelledby="navbarAo">
                                <div class="content px-4 py-3 bg-white">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i class="bi bi-tshirt me-2"><img 1754041258_0_440x.png"
                                                        style="width: 20px" alt="" /></i>
                                                ÁO THUN
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-thun-co-tron.html" class="sub-link">Áo Thun Cổ Tròn</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-polo.html" class="sub-link">Áo Polo</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-thun-tay-dai.html" class="sub-link">Áo Thun Tay Dài</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-tank-top.html" class="sub-link">Áo Tank Top (Áo Ba Lỗ)</a>
                                        </div>

                                        <div class="col-md-4">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i class="bi bi-person-badge me-2"></i> ÁO SƠ MI
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-somi-tay-ngan.html" class="sub-link">Áo Sơ Mi Tay Ngắn</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-somi-tay-dai.html" class="sub-link">Áo Sơ Mi Tay Dài</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-somi-khoac.html" class="sub-link">Áo Sơ Mi Khoác</a>
                                        </div>

                                        <div class="col-md-4">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i class="bi bi-snow me-2"></i> ÁO KHOÁC
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-parka.html" class="sub-link">Áo Khoác Parka</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-jean.html" class="sub-link">Áo Khoác Jean</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-kaki.html" class="sub-link">Áo Khoác Kaki</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-du.html" class="sub-link">Áo Khoác Dù</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-bomber.html" class="sub-link">Áo Khoác Bomber</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/ao/ao-khoac-hoodie.html" class="sub-link">Áo Khoác Hoodie</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item dropdown position-static">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarAo" role="button"
                                data-bs-toggle="dropdown">
                                QUẦN
                            </a>

                            <div class="dropdown-menu mega-menu" aria-labelledby="navbarAo">
                                <div class="content px-4 py-3 bg-white">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i>
                                                    <img quanshort.png" alt="" style="width: 20px" /></i>
                                                QUẦN SHORT
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-short-thun.html" class="sub-link">Quần Short thun</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-short-du.html" class="sub-link">Quần Short dù</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-short-kaki.html" class="sub-link">Quần Short kaki</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-short-active.html" class="sub-link">Quần Short active</a>
                                        </div>

                                        <div class="col-md-3">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i class=""><img quandai.png" alt="" style="width: 20px" /></i>
                                                QUẦN DÀI
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-tay.html" class="sub-link">Quần Tây</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-jogger.html" class="sub-link">Quần Jogger</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-kaki.html" class="sub-link">Quần Kaki</a>
                                        </div>

                                        <div class="col-md-3">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i><img quanjeans.png" alt="" style="width: 20px" /></i>
                                                QUẦN JEANS
                                            </span>
                                            <hr class="my-2" />
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-jeans-slim-fit.html" class="sub-link">Quần Jeans Slim
                                                Fit</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-jeans-loose-fit.html" class="sub-link">Quần Jeans Loose
                                                Fit</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-jeans-jogger.html" class="sub-link">Quần Jeans Jogger</a>
                                            <a href="${pageContext.request.contextPath}/Frontend-master/quan/quan-jeans-short.html" class="sub-link">Quần Jeans Short</a>
                                        </div>
                                        <div class="col-md-3">
                                            <span class="sub-title text-uppercase fw-bold">
                                                <i><img quanlot.png" alt="" style="width: 20px" /></i>
                                                QUẦN LÓT
                                            </span>
                                            <hr class="my-2" />
                                            <a href="quanlot/quanlot-soi-tu-nhien.html" class="sub-link">Quần lót sợi tự
                                                nhiên</a>
                                            <a href="quanlot/quanlot-seamless.html" class="sub-link">Quần lót
                                                Seamless</a>
                                            <a href="quanlot/quanlot-luabang.html" class="sub-link">Quần lót Lụa
                                                băng</a>
                                            <a href="quanlot/quanlot-thethao.html" class="sub-link">Quần lót thể
                                                thao</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="moi.html">MỚI</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cuahang.html">CỬA HÀNG</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="#">VIP</a></li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <i class="bi bi-search fs-5" style="cursor: pointer"></i>
                        <a href="login.html" style="cursor: pointer">
                            <i class="bi bi-person fs-5"></i>
                        </a>
                        <div class="position-relative" style="cursor: pointer">
                             
                            
                            <a href="cart.html" style="cursor: pointer">
                                <i class="bi bi-bag fs-5"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark"
                                style="font-size: 10px">
                                0
                            </span></a>
                            
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <section id="Slider">
        <div class="aspect-ratio-169">
            <img slide1.jpg" />
            <img slide2.jpg" />
            <img slide3.jpg" />
            <img slide4.jpg" />
            <img slide5.jpg" />
        </div>
        <div class="dot-container">
            <div class="dot active"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </section>
    <div class="marquee-container">
        <div class="marquee-content">
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
        </div>

        <div class="marquee-content" aria-hidden="true">
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
            <span>MIỄN PHÍ SHIP</span>
        </div>
    </div>
    <section class="py-5">
        <div class="container">
            <div class="mb-4">
                <h3 class="fw-bold text-uppercase" style="font-size: 24px">
                    Trạm 1 | Thời Trang Thiết Yếu
                </h3>
                <p class="text-muted" style="font-size: 14px; margin-top: 5px">
                    "Nền Tảng Phong Cách, Chất Lượng Vượt Thời Gian"
                </p>
            </div>

            <div class="row g-3 g-md-4">
                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh1.png" alt="SP1" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057 Xám
                                Đậm</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh2.png" alt="SP2" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057 Nâu
                                Nhạt</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh3.png" alt="SP3" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057
                                Đen</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh4.png" alt="SP4" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Áo Polo Tay Ngắn Mềm Mại Điều Hòa Nhiệt The Worker 005
                                Xanh</a>
                            <div class="price-box mt-2">
                                <span class="new-price">327.000 VND</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5">
                <a href="#" class="btn-view-all">Xem tất cả</a>
            </div>
        </div>
    </section>
    <section class="py-5">
        <div class="container">
            <div class="mb-4">
                <h3 class="fw-bold text-uppercase" style="font-size: 24px">
                    Trạm 2 | Thời Trang Công Nghệ
                </h3>
                <p class="text-muted" style="font-size: 14px; margin-top: 5px">
                    "Mặc Công Nghệ, Sống Thảnh Thơi"
                </p>
            </div>

            <div class="row g-3 g-md-4">
                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh1.png" alt="SP1" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057 Xám
                                Đậm</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh2.png" alt="SP2" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057 Nâu
                                Nhạt</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh3.png" alt="SP3" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Quần Short Thun Soft - Touch Mềm Mại Non Branded 057
                                Đen</a>
                            <div class="price-box mt-2">
                                <span class="old-price">297.000 VND</span>
                                <span class="new-price">282.150 VND</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-3">
                    <div class="product-card">
                        <div class="product-thumb position-relative overflow-hidden">
                            <a href="#">
                                <img tram1_hinh4.png" alt="SP4" class="w-100" />
                            </a>
                            <span class="badge-ship">Miễn Phí Ship</span>
                        </div>
                        <div class="product-info mt-3">
                            <a href="#" class="product-name">Áo Polo Tay Ngắn Mềm Mại Điều Hòa Nhiệt The Worker 005
                                Xanh</a>
                            <div class="price-box mt-2">
                                <span class="new-price">327.000 VND</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5">
                <a href="#" class="btn-view-all">Xem tất cả</a>
            </div>
        </div>
    </section>

    <footer class="bg-black text-white pt-5 pb-3">
        <div class="container">
            <div class="row border-bottom border-secondary pb-4 mb-5">
                <div class="col-md-3 d-flex align-items-center mb-3 mb-md-0">
                    <i class="bi bi-box-seam fs-2 me-3"></i>
                    <div>
                        <h6 class="fw-bold mb-0 text-uppercase">Miễn phí ship</h6>
                        <small class="text-secondary">Toàn quốc</small>
                    </div>
                </div>
                <div class="col-md-3 d-flex align-items-center mb-3 mb-md-0">
                    <i class="bi bi-shield-check fs-2 me-3"></i>
                    <div>
                        <h6 class="fw-bold mb-0 text-uppercase">Bảo hành</h6>
                        <small class="text-secondary">365 ngày</small>
                    </div>
                </div>
                <div class="col-md-3 d-flex align-items-center mb-3 mb-md-0">
                    <i class="bi bi-shop fs-2 me-3"></i>
                    <div>
                        <h6 class="fw-bold mb-0 text-uppercase">Địa chỉ</h6>
                        <small class="text-secondary">Cửa hàng YaMe VN</small>
                    </div>
                </div>
                <div class="col-md-3 d-flex align-items-center">
                    <i class="bi bi-journal-text fs-2 me-3"></i>
                    <div>
                        <h6 class="fw-bold mb-0 text-uppercase">Tạp chí</h6>
                        <small class="text-secondary">Thông tin thời trang</small>
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-6 col-lg-2 mb-4">
                    <h6 class="fw-bold text-uppercase mb-3">Quần Áo</h6>
                    <ul class="list-unstyled footer-links">
                        <li><a href="#">Áo Thun</a></li>
                        <li><a href="#">Áo Khoác</a></li>
                        <li><a href="#">Áo Sơ Mi</a></li>
                        <li><a href="#">Quần Dài</a></li>
                        <li><a href="#">Quần Short</a></li>
                        <li><a href="#">Quần Jeans</a></li>
                    </ul>
                </div>

                <div class="col-6 col-lg-2 mb-4">
                    <h6 class="fw-bold text-uppercase mb-3">Phụ Kiện</h6>
                    <ul class="list-unstyled footer-links">
                        <li><a href="#">Balo</a></li>
                        <li><a href="#">Túi Đeo</a></li>
                        <li><a href="#">Nón</a></li>
                        <li><a href="#">Ví</a></li>
                        <li><a href="#">Giày</a></li>
                        <li><a href="#">Dép</a></li>
                    </ul>
                </div>

                <div class="col-6 col-lg-2 mb-4">
                    <h6 class="fw-bold text-uppercase mb-3">GU của YaMe</h6>
                    <ul class="list-unstyled footer-links">
                        <li><a href="#" class="text-white fw-bold">GU ĐƠN GIẢN</a></li>
                        <li><a href="#">Trạm Thiết Yếu</a></li>
                        <li><a href="#">Trạm Công Nghệ</a></li>
                        <li>
                            <a href="#" class="text-white fw-bold mt-2 d-block">GU THIẾT KẾ</a>
                        </li>
                        <li><a href="#">Trạm Tận Hưởng</a></li>
                        <li><a href="#">Trạm Collab</a></li>
                    </ul>
                </div>

                <div class="col-6 col-lg-2 mb-4">
                    <h6 class="fw-bold text-uppercase mb-3">Về YaMe</h6>
                    <ul class="list-unstyled footer-links">
                        <li><a href="#">Giới Thiệu</a></li>
                        <li><a href="#">Cửa Hàng</a></li>
                        <li><a href="#">Bảo Hành</a></li>
                        <li><a href="#">Đổi Trả</a></li>
                        <li><a href="#">Chính Sách VIP</a></li>
                    </ul>
                </div>

                <div class="col-12 col-lg-4 mb-4">
                    <h6 class="fw-bold text-uppercase mb-3">
                        Gia nhập Cộng đồng YaMer
                    </h6>

                    <form class="mb-3">
                        <div class="input-group">
                            <input type="text" class="form-control bg-dark text-white border-0"
                                placeholder="Nhập email..." style="height: 45px" />
                            <button class="btn btn-light fw-bold" type="button" style="height: 45px">
                                Đăng Ký
                            </button>
                        </div>
                    </form>

                    <div class="social-icons mt-4">
                        <a href="#" class="me-3"><i class="bi bi-facebook fs-4"></i></a>
                        <a href="#" class="me-3"><i class="bi bi-tiktok fs-4"></i></a>
                        <a href="#" class="me-3"><i class="bi bi-youtube fs-4"></i></a>
                        <a href="#" class="me-3"><i class="bi bi-instagram fs-4"></i></a>
                    </div>
                </div>
            </div>

            <div class="border-top border-secondary pt-4 text-center text-secondary" style="font-size: 12px">
                <p class="mb-1">
                    © 2025 - HỘ KINH DOANH Y2010 - YAME VN. Mã số HKD: 0306194105-007 -
                    Đăng ký lần đầu: 06/03/2024
                </p>
                <p class="mb-1">
                    Cơ quan cấp: UBND Quận 10 - Phòng Tài chính - Kế hoạch. Địa chỉ đăng
                    ký kinh doanh: 766/3B Sư Vạn Hạnh (Nối dài), Phường 12, Quận 10,
                    TP.HCM
                </p>
                <p>
                    Điện thoại: (028) 3868 4857 - Mua hàng: (028) 7307 1441 - Email:
                    cskh@yame.vn
                </p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>