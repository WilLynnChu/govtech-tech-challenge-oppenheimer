package objectRepository;

public class APIObject {
	
	public static String api = null;
	public static String base_url = "http://localhost:9997";
	public static String base_api_url = base_url + "/api/v1";
	public static String create_hero_api = base_api_url + "/hero";
	public static String create_hero_voucher_api = create_hero_api + "/vouchers";
	public static String get_hero_owe_money_api = create_hero_api + "/owe-money";
	public static String get_voucher_by_person_type_api = base_api_url + "/voucher/by-person-and-type";
}
