require "rails_helper"

describe "Application Routing" do
  describe "terms#index" do
    it "routes GET / and GET /terms" do
      expect(get: "/").to route_to("terms#index")
      expect(root_path).to eq("/")

      expect(get: "/terms").to route_to("terms#index")
      expect(terms_path).to eq("/terms")
    end
  end

  describe "agendas#show", type: :request do
    it "redirects GET /agendas/<token> to /agendas/<token>/schedules" do
      get("/agendas/a_token")
      expect(response).to redirect_to("/agendas/a_token/schedules")
    end
  end

  describe "schedules#index" do
    it "routes GET /agendas/<token>/schedules" do
      expect(get: "/agendas/a_token/schedules").to route_to("schedules#index", agenda_token: "a_token")
      expect(agenda_schedules_path("a_token")).to eq("/agendas/a_token/schedules")
    end

    it "routes with a valid page query param" do
      expect(get: "/agendas/a_token/schedules?page=1")
        .to route_to("schedules#index", agenda_token: "a_token", page: "1")
    end

    it "does not route on an invalid paga query param" do
      expect(get: "/agendas/a_token/schedules?page=-1").not_to be_routable
      expect(get: "/agendas/a_token/schedules?page=0").not_to be_routable
      expect(get: "/agendas/a_token/schedules?page=a").not_to be_routable
    end
  end

  describe "schedules#show" do
    it "routes GET /agendas/<token>/schedules/<index>" do
      expect(get: "/agendas/a_token/schedules/1")
        .to route_to("schedules#show", agenda_token: "a_token", index: "1")
      expect(agenda_schedule_path("a_token", index: 1)).to eq("/agendas/a_token/schedules/1")
    end

    it "does not route on an invalid index" do
      expect(get: "/agendas/a_token/schedules/-1").not_to be_routable
      expect(get: "/agendas/a_token/schedules/0").not_to be_routable
      expect(get: "/agendas/a_token/schedules/a").not_to be_routable
    end
  end
end
