//
//  MapaViewController.swift
//  Agenda
//
//  Created by Breno Luizetto Cintra on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    //MARK: - Outlet
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        mapa.delegate = localizacao
        verificaAutorizacaoDoUsuario()
        gerenciadorDeLocalizacao.delegate = self
    }
    
    //MARK: - Métodos
    
    func verificaAutorizacaoDoUsuario(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .authorizedWhenInUse:
                let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
                mapa.addSubview(botao)
                gerenciadorDeLocalizacao.startUpdatingLocation()
                
                break
                
            case .notDetermined:
                gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
                
                break
                
            case .denied:
                
                break
            default:
                break
                
            }
        }
    }
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Caelum - São Paulo")
        { (localizacaoEncontrada) in
            let pino = Localizacao().configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada, cor: .black, icon: nil)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
            self.localizarAluno()
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!, local:  { (localizacaoEncontrada) in
//                let pino = self.connfiguraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icon: nil)
                
                self.mapa.addAnnotation(pino)
                self.mapa.showAnnotations(self.mapa.annotations, animated: true)
            })
            
        }
    }
    
    
    
        func getTitulo() -> String{
            return "Localizar Alunos"
        }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
            
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
            mapa.addSubview(botao)
            gerenciadorDeLocalizacao.startUpdatingLocation()
        default:
            break
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
 
    
  


}
