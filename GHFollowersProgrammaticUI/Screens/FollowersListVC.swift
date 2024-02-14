//
//  FollowersListVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 16/12/23.
//


import UIKit

class FollowersListVC: UIViewController {
    
    
    
    enum Section{case main}
    
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    //bu data source generic olarak 2 tane parametre aliyor ve hash functionslari kabul ediyor bu diffable data source. Burada verecegimiz 2 generic parametrenin hashable'i kabul etmesi gerekiyor. Ilk olarak collection View'imizin section'inin vermemiz gerekiyor. Bizim collection view sadece 1 section'a sahip. Onu ustte zaten enum olarak verdik. Bu arada enum'lar default olarak hashable dir zaten. Bu yuzden main adinda bir section'i enum'da olusturduk. 2. parametremiz follower object olacak. Follower objectimiz hashable degildir. Onu Model dizinine gidip decodable'in yanina hashable yazarak hashable yaptik.
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
        
        //ViewdidLoad'in bu sekilde duzenli olmasi sana burada neler olup bittigine dair fikir veriyor. Kodun okunabilirligini arttiriyor. Sen de sonradan geldiginde anlayacaksin baskasi da... book table of contents gibi.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        //viewWillAppear fonksiyonu içinde, üst çubuğun görünürlüğü ayarlanmış.

    }
    
    
    func configureViewController(){
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // Buyuk olmasini istiyoruz.
        
        //configureViewController fonksiyonu içinde, navigationController özellikleri ayarlanarak görünümün arka plan rengi belirlenmiş.
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)) // Ilk olarak collectionViewimizi initialize etmemiz gerekiyor. Yani yerlestiriyoruz ekrana aslinda. burada frame olarak view.bounds verecegiz cunku collection view zaten tum ekrani kaplayacak.  Direkt view'i fill up doldur diyoruz.view.bounds ifadesi, koleksiyon görünümünün başlangıç çerçevesini, içinde bulunduğu üst düzey görünümün sınırları ile aynı boyut ve konumda olacak şekilde belirler. Yani, koleksiyon görünümü, içinde bulunduğu görünümün tamamını kaplar.
        
        
        //collectionViewLayout: UICollectionViewFlowLayout(): Bu, koleksiyon görünümünün düzenini belirleyen bir özelliktir. UICollectionViewFlowLayout, temelde bir ızgara düzeni oluşturmak için kullanılan bir düzen nesnesidir. Bu ifade, koleksiyon görünümüne bir ızgara düzeni uygulayarak, veri öğelerini belirli bir düzen içinde görüntülemesini sağlar.
        //Daha sonra buraya gelip kendi custom Flow Layoutumuzu gosterecegiz. Daha sonra onu yazacagiz.
        
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    //configureCollectionView fonksiyonu içinde, UICollectionView özellikleri ayarlanarak collectionView oluşturulmuş ve görünüme eklenmiştir. Ayrıca, hücre kaydı da yapılmış.
        
        
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false  //searche bastiginda alttaki collectionview'in kararmasini onluyor.
        navigationItem.hidesSearchBarWhenScrolling = false // bunu yazmazsan scroll yapmadikca search bar gozukmuyor.
        navigationItem.searchController = searchController
        
        
    }
    
   
    
    func getFollowers(username: String, page: Int){
        showLoadingView() //viewControllerin extensionu oldugu icin direkt bu sekilde yazabiliyoruz cunku tum viewcontrollerlar buna sahip...
        
        
        
        
        //Buraya sonradan usernmae ve page parametrelerini ekledik...
        
        
        //Gordugun gibi asagida network manager var. Network call'i burada yapiyoruz. network managerimiz asagida gordugun gibi self.followers = followers self.update() tarzinda strong reference lere sahip. Burada self dedigimiz tabi ki bizim bu classimiz yani follower list vc.. this could cause memory leak.. we would like to make this self a weak variable. Bunu bu sekilde [weak self] -> capture list deniyor buna galiba.. yazarak selfi weak yapabiliyoruz. bu durum selflerin optional olma ihtiyacina sebep oluyor cok dogal olarak. Cunku weak oldugu icin gelmeyebilir vibe 'i olusuyor. selflerin oraya ? koymamak icin
        NetworkManager.sharedd.getFollowers(for: username, page: page) { [weak self] result in
            
            
            
            //swift 4.2 de tanitilan su kod satirini buraya koyabilirsin ancak ben koymak istemiyorum. guard let self = self else {return} seklinde yazabilirsin.
            
            //evet suanda bu kisimda isimiz kalmadi. Ileride proje icinde baska yerlerde de network call yapacagiz. orada  bu arc fikrini reinforce edecegiz iyice.. 
            
            switch result {
            case.success(let followers):
                
                guard let self = self else {return}
                
                // #warning("Call dismis here") //bu bir warning bu seilde yazilabiliyor sanirim
                self.dismissLoadingView()

                if followers.count < 100 { self.hasMoreFollowers = false} //Burada direkt false yapiyoruz ki scrol yapmasin...
                self.followers.append(contentsOf: followers) //Buradaki self.followers yukarida olusturdugumuz dizi...
               
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀."
                    DispatchQueue.main.async{
                        self.ShowEmptyStateView(message: message, view: self.view) //closureda oldugumuz icin self koyacagiz mecbur. Zaten extension oldugu icin geliyor direkt.
                        return
                    }
                }
                
                
                self.updateData(followers: self.followers)
                
            case.failure(let error):
                self?.presenatGFAlertOnMainThread(title: "Bad stuff Happend", message: error.rawValue , buttonTitle: "OK")
                
            }
            //getFollowers fonksiyonu içinde, ağ çağrısı yapılarak takipçi bilgileri alınmış.

        }
    }
    
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell //burada as yapiyoruz cunku as den oncesi regular default cell dir. bizim bunu follower cell olarak cast etmemiz gerekiyor.
            cell.set(follower: follower) //followerCell swift dosyasindan set fonksiyonunu cagirdik ve set ettik. Yani cell'imizi burada aslinda follower cell dosyasina follower'i gondererek baslatmis olduk...
            //bu cell 'i su sekild  e configure edenlerde var. Bu cell bizim olusturdugumuz cell swift dosyasini represent eden cell zaten anladigim kadariyla ve oraya direkt ulasiyor.
//            cell.avatarImage
//            cell.usernameLabel = ......   seklinde configure edenlerde var. ancak biz tek satirda hallediyoruz isi..
            
            
            return cell
            
            
            //aslinda burada ilk olarak resuable bir cell olusturduk, daha sonra o cell'i configure ettik ve en sonda dondurduk.
            //configureDataSource fonksiyonu içinde, UICollectionViewDiffableDataSource oluşturulmuş ve cellProvider kullanılarak hücreler için veri sağlanmış.
        } )
        
        
    }
    
    
    func updateData(followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
        }
     
        //updateData fonksiyonu içinde, NSDiffableDataSourceSnapshot kullanılarak veriler güncellenmiş ve görünüme yansıtılmış.
        
        
        
    }
    
    
  
}


extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y // Bu satır, kullanıcının şu anda görüntülenen içeriğin en üstünden ne kadar uzakta olduğunu belirten bir değişkeni tanımlar.
        
        
        let contentHeight = scrollView.contentSize.height //Bu satır, koleksiyon görünümündeki toplam içeriğin yüksekliğini temsil eden bir değişkeni tanımlar.
        
        
        let height = scrollView.frame.size.height //Bu satır, koleksiyon görünümünün görünen yüksekliğini temsil eden bir değişkeni tanımlar.
        
        
        //Bu if koşulu, kullanıcının sayfanın sonuna gelip gelmediğini kontrol eder. Eğer kullanıcı sayfanın sonuna geldiyse, içeriğin daha fazla yüklenip yüklenmediğini kontrol etmek üzere bir dizi koşul eklenir. Mesela content height demek toplam user'in yuksekligi... Mesela 2000 tane var. Hepsini yuksekligi demek. Ornegin 100 metre olsun heighte 50 olsun yani o anki user icin yukseklik
        if offsetY > contentHeight - height {
            
            guard hasMoreFollowers else {return}//Bu satır, daha fazla takipçi olup olmadığını kontrol eder. Eğer daha fazla takipçi yoksa, fonksiyonu terk eder. Cunku eger adamin mesela 10 takipcisi varsa daha fazla follower getirmene gerek yoktur... O yuzden bunu kontrol etmen gerekiyor. Yukarida getFollowers fonksiyonunda buna count yaparak bakiyoruz zaten.
            
            page += 1 // Eğer daha fazla takipçi varsa, sayfa numarasını bir artırarak bir sonraki sayfayı almak için hazırlık yapılır.
            
            
            //Burada page number'i counter olarak kullaniyoruz aslinda.  Page sayisini ustte 1 arttirdik ve buraya parametre olarak gonderdik.. Zaten en ustte de page variableimizi olusturduk...Zaten ilk calistirildiginda page 1 olarak calisacak scroll edip en alta geldigimizce 2 olacak bu fonksiyon icerisinde.
            getFollowers(username: username, page: page) // Bu satır, getFollowers fonksiyonunu çağırarak belirtilen kullanıcı adı ve sayfa numarasıyla yeni takipçileri almayı sağlar
        }
        
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        if( isSearching == false){
            let follower = followers[indexPath.item] //This is the what is tapped
        }
        else{
            let follower = filteredFollowers[indexPath.item]
        }
        Bunu bu sekilde yapmak yerine daha pratik bir yol var 2 satirda isi cozuyoruz... W ? T: F yontemi yani What ? True or False demek.
         
         Eğer isSearching değişkeni true ise, o zaman activeArray değişkeni filteredFollowers dizisinin değerini alır.
         Eğer isSearching değişkeni false ise, o zaman activeArray değişkeni followers dizisinin değerini alır.
         */
        
        let activeArray = isSearching ? filteredFollowers : followers
        let followerUser = activeArray[indexPath.item]
        
        
        
        let destinationVC = UserInfoVC()
        
        destinationVC.username = followerUser.login
        
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
        
        
        
    }
   
    
   
}

extension FollowersListVC: UISearchResultsUpdating,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //Burada searchbardaki yazi degistikce search'in update olmasinin ayarlayacagiz. burada arrayimizi filterlayacagiz ve collectionViewimizi ona gore update edecegiz. Ilk olarak searchController'in searchbarinda text oldugundan emin olmaliyiz.
        
        //2. kisminda empty olup olmadigina da bakiyoruz. Iste empty olursa search result'i update etmemis olacagiz. Direkt return ile cikiyoruz.
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        
        //burada filter olmus yeni bir array'e ihtiyacimiz var. Cunku collection view'da her seferinde onu gosterecegiz. Bu sekilde update edilmis olacak.
        //CollectionViewda da zaten array of followers var yani. Yani searchBar da yazdigimiz texte gore filter olacak mevcut array her seferinde.
        //Bunun icin en ustte filteredArray follower olusturuyourz.
        
        isSearching  = true
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())} //buradaki filter'in olayi ile ilgili sean allen'in videosu var. Bu rabbit hole'a girmeyelim simdi.
    updateData(followers: filteredFollowers)
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false //Bu arada isSearching.toggle() diye bir sey var direkt boolena'i flip ediyormus galiba...
        updateData(followers: followers)
    }
    
    
}


